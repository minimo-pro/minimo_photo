package com.khlebobul.minimo_photo

import java.io.File
import java.io.InputStream
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicReference
import org.junit.Assert.*
import org.junit.Test

class PhotoImportSessionTest {
    @Test fun cancellationRetiresAProviderThatBlocksReadAndClose() {
        val directory = kotlin.io.path.createTempDirectory().toFile()
        val output = File(directory, "partial.jpg")
        val previous = File(directory, "previous.jpg")
        val source = File(directory, "original.jpg").apply { writeBytes(byteArrayOf(8)) }
        val reading = CountDownLatch(1)
        val closing = CountDownLatch(1)
        val release = CountDownLatch(1)
        val session = PhotoImportSession()
        session.copy(previous) { byteArrayOf(1).inputStream() }
        val failure = AtomicReference<Throwable?>()
        val worker = Thread {
            try {
                session.copy(output) {
                    object : InputStream() {
                        override fun read(): Int = error("bulk reads only")
                        override fun read(buffer: ByteArray, offset: Int, length: Int): Int {
                            reading.countDown()
                            release.await()
                            buffer[offset] = 9
                            return 1
                        }
                        override fun close() {
                            closing.countDown()
                            release.await()
                        }
                    }
                }
            } catch (error: Throwable) { failure.set(error) }
        }.apply { isDaemon = true; start() }
        try {
            assertTrue(reading.await(2, TimeUnit.SECONDS))
            val cancelled = CountDownLatch(1)
            Thread { session.cancel(); cancelled.countDown() }.apply { isDaemon = true; start() }
            assertTrue("cancel must not wait for provider read/close", cancelled.await(2, TimeUnit.SECONDS))
            assertTrue(closing.await(2, TimeUnit.SECONDS))
            assertFalse(output.exists())
            assertFalse(previous.exists())
            assertArrayEquals(byteArrayOf(8), source.readBytes())
            // A retired worker must not write to or delete a reused path.
            output.writeBytes(byteArrayOf(7))
            release.countDown()
            worker.join(2000)
            assertFalse(worker.isAlive)
            assertTrue(failure.get() is IllegalStateException)
            assertArrayEquals(byteArrayOf(7), output.readBytes())
        } finally {
            release.countDown()
            worker.join(2000)
            directory.deleteRecursively()
        }
    }

    @Test fun lateProviderOpenCannotCreateAFileAfterCancellation() {
        val directory = kotlin.io.path.createTempDirectory().toFile()
        val output = File(directory, "late.jpg")
        val opening = CountDownLatch(1)
        val release = CountDownLatch(1)
        val closed = CountDownLatch(1)
        val session = PhotoImportSession()
        val worker = Thread {
            runCatching {
                session.copy(output) {
                    opening.countDown()
                    release.await()
                    object : java.io.ByteArrayInputStream(byteArrayOf(1)) {
                        override fun close() { closed.countDown(); super.close() }
                    }
                }
            }
        }.apply { isDaemon = true; start() }
        try {
            assertTrue(opening.await(2, TimeUnit.SECONDS))
            session.cancel()
            release.countDown()
            worker.join(2000)
            assertFalse(worker.isAlive)
            assertTrue(closed.await(2, TimeUnit.SECONDS))
            assertFalse(output.exists())
        } finally { release.countDown(); worker.join(2000); directory.deleteRecursively() }
    }

    @Test fun completedFilesBelongToTheCaller() {
        val directory = kotlin.io.path.createTempDirectory().toFile()
        try {
            val output = File(directory, "photo.jpg")
            val session = PhotoImportSession()
            session.copy(output) { byteArrayOf(1, 2, 3).inputStream() }
            session.complete()
            session.cancel()
            assertArrayEquals(byteArrayOf(1, 2, 3), output.readBytes())
        } finally { directory.deleteRecursively() }
    }
}
