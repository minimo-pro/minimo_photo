package com.khlebobul.minimo_photo

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.content.pm.ServiceInfo
import android.net.Uri
import io.flutter.plugin.common.MethodChannel
import android.os.Build
import android.os.IBinder
import android.os.PowerManager

/** Keeps picker copies or the sequential compression batch alive while hidden. */
class PhotoProcessingService : Service() {
    companion object {
        @Volatile var expiredToken: Long? = null
        var compressionChannel: MethodChannel? = null
        var onImportCancelled: ((Long) -> Unit)? = null
    }
    private var token = -1L
    private var compressing = false
    private var finished = false
    private var wakeLock: PowerManager.WakeLock? = null

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val id = intent?.getLongExtra("token", -1) ?: -1
        if (intent?.action == "start") {
            token = id
            compressing = intent.getBooleanExtra("compression", false)
            finished = false
            if (Build.VERSION.SDK_INT >= 26) {
                getSystemService(NotificationManager::class.java).createNotificationChannel(
                    NotificationChannel(channelId, if (compressing) "Photo compression" else "Photo import",
                        NotificationManager.IMPORTANCE_LOW)
                )
            }
            try {
                if (Build.VERSION.SDK_INT >= 29) {
                    val type = if (compressing && Build.VERSION.SDK_INT >= 35)
                        ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROCESSING
                    else ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC
                    startForeground(4208, notification(0, 0), type)
                } else {
                    startForeground(4208, notification(0, 0))
                }
            } catch (_: Exception) {
                cancel()
                stopSelf()
                return START_NOT_STICKY
            }
            wakeLock?.let { if (it.isHeld) it.release() }
            wakeLock = (getSystemService(POWER_SERVICE) as PowerManager)
                .newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "minimo:processing").apply {
                    acquire(6 * 60 * 60 * 1000L)
                }
        } else if (id == token) {
            if (finished) {
                stopSelf(startId)
                return START_NOT_STICKY
            }
            when (intent?.action) {
                "update" -> getSystemService(NotificationManager::class.java).notify(
                    4208, notification(intent.getIntExtra("processed", 0), intent.getIntExtra("total", 0),
                        intent.getIntExtra("progress", -1))
                )
                "finish" -> { finished = true; stopSelf(startId) }
                "cancel" -> { cancel(); stopSelf(startId) }
            }
        } else if (token == -1L) {
            stopSelf(startId)
        }
        return START_NOT_STICKY
    }

    private val channelId get() = if (compressing) "photo_compression" else "photo_import"

    private fun cancel() {
        expiredToken = token
        if (finished) return
        finished = true
        if (compressing) compressionChannel?.invokeMethod("cancel", token.toString())
        else onImportCancelled?.invoke(token)
    }

    private fun notification(processed: Int, total: Int, progress: Int = -1): Notification {
        val builder = if (Build.VERSION.SDK_INT >= 26) Notification.Builder(this, channelId)
            else @Suppress("DEPRECATION") Notification.Builder(this)
        val open = PendingIntent.getActivity(this, 0, Intent(this, MainActivity::class.java),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val cancel = PendingIntent.getService(this, 0,
            Intent(this, PhotoProcessingService::class.java).setAction("cancel")
                .setData(Uri.parse("minimo-photo://processing/$token")).putExtra("token", token),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val percent = if (progress >= 0) progress / 10 else if (total > 0) processed * 100 / total else 0
        return builder.addAction(Notification.Action.Builder(null,
            getString(android.R.string.cancel), cancel).build()).setSmallIcon(android.R.drawable.stat_sys_download)
            .setContentTitle("minimo")
            .setContentText(if (total > 0) "$processed / $total · $percent%" else "…")
            .setContentIntent(open).setOngoing(true).setOnlyAlertOnce(true)
            .setProgress(if (progress >= 0) 1000 else total,
                if (progress >= 0) progress else processed, total == 0).build()
    }

    override fun onTimeout(startId: Int, fgsType: Int) {
        cancel()
        stopSelf()
    }

    override fun onDestroy() {
        cancel()
        wakeLock?.let { if (it.isHeld) it.release() }
        wakeLock = null
        stopForeground(STOP_FOREGROUND_REMOVE)
        super.onDestroy()
    }
}
