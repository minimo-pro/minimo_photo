package com.khlebobul.minimo_photo

import android.content.Intent
import org.junit.Assert.*
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.Robolectric
import org.robolectric.Shadows.shadowOf
import org.robolectric.annotation.Config

@RunWith(org.robolectric.RobolectricTestRunner::class)
@Config(sdk = [28], manifest = Config.NONE)
class PhotoProcessingServiceTest {
    @Test fun queuedCommandsForFinishedTokenRetryShutdownWithTheirOwnStartId() {
        val controller = Robolectric.buildService(PhotoProcessingService::class.java).create()
        val service = controller.get()
        fun command(action: String, token: Long, startId: Int) {
            service.onStartCommand(Intent(action).putExtra("token", token), 0, startId)
        }
        try {
            command("start", 10, 1)
            command("finish", 10, 2)
            assertEquals(2, shadowOf(service).stopSelfId)
            command("update", 10, 3)
            assertEquals(3, shadowOf(service).stopSelfId)
            command("finish", 10, 4)
            assertEquals(4, shadowOf(service).stopSelfId)
        } finally { controller.destroy() }
    }

    @Test fun oldCommandsCannotStopANewerStart() {
        val controller = Robolectric.buildService(PhotoProcessingService::class.java).create()
        val service = controller.get()
        fun command(action: String, token: Long, startId: Int) {
            service.onStartCommand(Intent(action).putExtra("token", token), 0, startId)
        }
        try {
            command("start", 10, 1)
            command("finish", 10, 2)
            command("start", 20, 3)
            command("update", 10, 4)
            command("finish", 10, 5)
            assertEquals(2, shadowOf(service).stopSelfId)
            command("finish", 20, 6)
            assertEquals(6, shadowOf(service).stopSelfId)
        } finally { controller.destroy() }
    }
}
