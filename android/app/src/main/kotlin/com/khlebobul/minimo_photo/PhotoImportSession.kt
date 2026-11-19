package com.khlebobul.minimo_photo

import java.io.File
import java.io.InputStream
import java.io.OutputStream

/** Owns cache files until handoff; provider I/O never holds the cancellation lock. */
internal class PhotoImportSession {
    private val lock = Any()
    private val files = mutableSetOf<File>()
    private var input: InputStream? = null
    private var output: OutputStream? = null
    @Volatile var isCancelled = false
        private set

    fun copy(destination: File, openInput: () -> InputStream) {
        check(!isCancelled) { "photo import cancelled" }
        try {
            val source = openInput()
            var attached = false
            try {
                synchronized(lock) {
                    check(!isCancelled) { "photo import cancelled" }
                    input = source
                    attached = true
                    files.add(destination)
                    output = destination.outputStream()
                }
                val buffer = ByteArray(DEFAULT_BUFFER_SIZE)
                while (!isCancelled) {
                    val count = source.read(buffer)
                    if (count < 0) break
                    synchronized(lock) {
                        check(!isCancelled) { "photo import cancelled" }
                        output!!.write(buffer, 0, count)
                    }
                }
                check(!isCancelled) { "photo import cancelled" }
            } finally {
                val (destinationToClose, sourceToClose) = synchronized(lock) {
                    val writer = output
                    output = null
                    val reader = if (input === source) {
                        input = null
                        source
                    } else if (!attached) source else null
                    writer to reader
                }
                try { destinationToClose?.close() } finally { sourceToClose?.close() }
            }
        } catch (error: Exception) {
            synchronized(lock) {
                if (files.remove(destination)) destination.delete()
            }
            throw error
        }
    }

    fun complete() = synchronized(lock) {
        check(!isCancelled) { "photo import cancelled" }
        files.clear()
    }

    fun cancel() {
        val reader = synchronized(lock) {
            if (isCancelled) return
            isCancelled = true
            runCatching { output?.close() }
            output = null
            files.forEach { it.delete() }
            files.clear()
            input.also { input = null }
        }
        // shortcut: a provider may ignore close; add provider-specific aborts if retired readers accumulate.
        if (reader != null) Thread { runCatching { reader.close() } }.apply {
            isDaemon = true
            start()
        }
    }
}
