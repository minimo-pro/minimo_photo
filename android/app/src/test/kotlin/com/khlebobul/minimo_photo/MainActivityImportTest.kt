package com.khlebobul.minimo_photo

import java.io.File
import java.io.InputStream
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import io.flutter.plugin.common.MethodChannel
import org.junit.Assert.*
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.Robolectric
import org.robolectric.annotation.Config

@RunWith(org.robolectric.RobolectricTestRunner::class)
@Config(sdk = [28], manifest = Config.NONE)
class MainActivityImportTest {
    @Test fun cancellingABlockedImportClearsAndSettlesThePickOnce() {
        val activity = Robolectric.buildActivity(MainActivity::class.java).get()
        val directory = kotlin.io.path.createTempDirectory().toFile()
        val output = File(directory, "partial.jpg")
        val session = PhotoImportSession()
        val reading = CountDownLatch(1)
        val release = CountDownLatch(1)
        var completions = 0
        val result = object : MethodChannel.Result {
            override fun success(value: Any?) { assertEquals(emptyList<Any>(), value); completions++ }
            override fun error(code: String, message: String?, details: Any?) = fail(code)
            override fun notImplemented() = fail("not implemented")
        }
        fun set(name: String, value: Any?) {
            MainActivity::class.java.getDeclaredField(name).apply { isAccessible = true }.set(activity, value)
        }
        fun get(name: String): Any? = MainActivity::class.java.getDeclaredField(name)
            .apply { isAccessible = true }.get(activity)
        set("activePickId", 10L)
        set("pendingPickResult", result)
        set("pickImport", session)
        val worker = Thread {
            runCatching {
                session.copy(output) {
                    object : InputStream() {
                        override fun read(): Int { reading.countDown(); release.await(); return -1 }
                    }
                }
            }
        }.apply { isDaemon = true; start() }
        try {
            assertTrue(reading.await(2, TimeUnit.SECONDS))
            val cancel = MainActivity::class.java.getDeclaredMethod("cancelPick").apply { isAccessible = true }
            cancel.invoke(activity)
            assertEquals(1, completions)
            assertNull(get("pendingPickResult"))
            assertNull(get("activePickId"))
            assertNull(get("pickImport"))
            assertFalse(output.exists())
            cancel.invoke(activity)
            assertEquals(1, completions)
            val nextSession = PhotoImportSession()
            set("activePickId", 20L)
            set("pendingPickResult", result)
            set("pickImport", nextSession)
            MainActivity::class.java.getDeclaredMethod(
                "finishPhotoPick", Long::class.javaPrimitiveType, PhotoImportSession::class.java, List::class.java
            ).apply { isAccessible = true }.invoke(activity, 10L, session, emptyList<Map<String, Any>>())
            assertEquals(1, completions)
            assertEquals(20L, get("activePickId"))
            assertSame(result, get("pendingPickResult"))
            assertSame(nextSession, get("pickImport"))
        } finally { release.countDown(); worker.join(2000); directory.deleteRecursively() }
    }
}
