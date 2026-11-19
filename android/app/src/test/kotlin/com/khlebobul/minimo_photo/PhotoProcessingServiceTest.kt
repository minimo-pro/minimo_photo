package com.khlebobul.minimo_photo

import android.content.Intent
import android.app.Notification
import android.app.NotificationManager
import org.junit.Assert.*
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.Robolectric
import org.robolectric.Shadows.shadowOf
import org.robolectric.annotation.Config

@RunWith(org.robolectric.RobolectricTestRunner::class)
@Config(sdk = [28], manifest = Config.NONE)
class PhotoProcessingServiceTest {
    @Test fun notificationShowsProgressAndKeepsCancellationBoundToItsOperation() {
        val controller = Robolectric.buildService(PhotoProcessingService::class.java).create()
        val service = controller.get()
        val notifications = shadowOf(service.getSystemService(NotificationManager::class.java))
        try {
            service.onStartCommand(Intent("start").putExtra("token", 10L), 0, 1)
            assertTrue(shadowOf(service).lastForegroundNotification.extras
                .getBoolean(Notification.EXTRA_PROGRESS_INDETERMINATE))
            service.onStartCommand(Intent("update").putExtra("token", 10L)
                .putExtra("processed", 2).putExtra("total", 4), 0, 2)
            val importing = notifications.getNotification(4208)
            assertEquals(4, importing.extras.getInt(Notification.EXTRA_PROGRESS_MAX))
            assertEquals(2, importing.extras.getInt(Notification.EXTRA_PROGRESS))
            assertEquals("2 / 4 · 50%", importing.extras.getString(Notification.EXTRA_TEXT))
            assertTrue(importing.flags and Notification.FLAG_ONGOING_EVENT != 0)
            val oldCancel = importing.actions.single().actionIntent

            service.onStartCommand(Intent("start").putExtra("token", 20L)
                .putExtra("compression", true), 0, 3)
            service.onStartCommand(Intent("update").putExtra("token", 20L)
                .putExtra("processed", 1).putExtra("total", 4).putExtra("progress", 250), 0, 4)
            val compressing = notifications.getNotification(4208)
            assertEquals(1000, compressing.extras.getInt(Notification.EXTRA_PROGRESS_MAX))
            assertEquals(250, compressing.extras.getInt(Notification.EXTRA_PROGRESS))
            assertEquals("1 / 4 · 25%", compressing.extras.getString(Notification.EXTRA_TEXT))
            val oldIntent = shadowOf(oldCancel).savedIntent
            assertEquals(10L, oldIntent.getLongExtra("token", -1))
            val stoppedAt = shadowOf(service).stopSelfId
            service.onStartCommand(oldIntent, 0, 5)
            assertEquals(stoppedAt, shadowOf(service).stopSelfId)
            service.onStartCommand(shadowOf(compressing.actions.single().actionIntent).savedIntent, 0, 6)
            assertEquals(20L, PhotoProcessingService.expiredToken)
            assertEquals(6, shadowOf(service).stopSelfId)
        } finally { controller.destroy() }
        assertNull(notifications.getNotification(4208))
    }

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
