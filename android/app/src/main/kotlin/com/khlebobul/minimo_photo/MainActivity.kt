package com.khlebobul.minimo_photo

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import android.provider.OpenableColumns
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.UUID

class MainActivity : FlutterActivity() {
    private lateinit var photosChannel: MethodChannel
    private lateinit var externalPhotosChannel: MethodChannel
    private val pendingExternalUris = mutableListOf<Uri>()
    private var pendingPickResult: MethodChannel.Result? = null
    @Volatile private var activePickId: Long? = null
    private var nextPickId = 0L
    private var copyingPhotos = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        photosChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "minimo_photo/photos")
        photosChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "pickPhotos" -> pickPhotos(call.arguments, result)
                "cancelPhotoPick" -> cancelPhotoPick(result)
                else -> result.notImplemented()
            }
        }
        externalPhotosChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "minimo_photo/external_photos")
        externalPhotosChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "consumeExternalPhotos" -> consumeExternalPhotos(result)
                else -> result.notImplemented()
            }
        }
        importExternalIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        importExternalIntent(intent)
    }

    private fun importExternalIntent(intent: Intent?) {
        val externalIntent = intent ?: return
        if (externalIntent.action !in setOf(Intent.ACTION_SEND, Intent.ACTION_SEND_MULTIPLE)) return
        val uris = buildList {
            if (Build.VERSION.SDK_INT >= 33) {
                externalIntent.getParcelableExtra(Intent.EXTRA_STREAM, Uri::class.java)?.let(::add)
                externalIntent.getParcelableArrayListExtra(Intent.EXTRA_STREAM, Uri::class.java)?.let(::addAll)
            } else {
                @Suppress("DEPRECATION")
                externalIntent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)?.let(::add)
                @Suppress("DEPRECATION")
                externalIntent.getParcelableArrayListExtra<Uri>(Intent.EXTRA_STREAM)?.let(::addAll)
            }
            externalIntent.clipData?.let { clip ->
                for (index in 0 until clip.itemCount) add(clip.getItemAt(index).uri)
            }
        }.distinct().take(50)
        if (uris.isEmpty()) return
        pendingExternalUris.addAll(uris.filterNot(pendingExternalUris::contains))
        externalPhotosChannel.invokeMethod("externalPhotosAvailable", null)
    }

    private fun consumeExternalPhotos(result: MethodChannel.Result) {
        val uris = pendingExternalUris.toList()
        if (uris.isEmpty()) return result.success(null)
        Thread {
            val photos = uris.mapNotNull { uri -> runCatching { copyPickedPhoto(uri) }.getOrNull() }
            runOnUiThread {
                pendingExternalUris.removeAll(uris.toSet())
                result.success(if (photos.isEmpty()) null else mapOf("files" to photos))
            }
        }.start()
    }

    private fun pickPhotos(arguments: Any?, result: MethodChannel.Result) {
        if (pendingPickResult != null) {
            result.error("pick_in_progress", "photo picker is already open", null)
            return
        }
        pendingPickResult = result
        activePickId = ++nextPickId
        val source = (arguments as? Map<*, *>)?.get("source") as? String ?: "gallery"
        val intent = if (source == "files") {
            Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
                addCategory(Intent.CATEGORY_OPENABLE)
                type = "image/*"
                putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            Intent(MediaStore.ACTION_PICK_IMAGES).apply {
                type = "image/*"
                putExtra(MediaStore.EXTRA_PICK_IMAGES_MAX, minOf(50, MediaStore.getPickImagesMaxLimit()))
            }
        } else {
            Intent(Intent.ACTION_GET_CONTENT).apply {
                addCategory(Intent.CATEGORY_OPENABLE)
                type = "image/*"
                putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true)
            }
        }
        startActivityForResult(intent, PICK_PHOTOS_REQUEST)
    }

    private fun cancelPhotoPick(result: MethodChannel.Result) {
        val cancelledResult = pendingPickResult
        val wasPicking = activePickId != null
        if (!copyingPhotos) pendingPickResult = null
        activePickId = null
        if (wasPicking) finishActivity(PICK_PHOTOS_REQUEST)
        if (!copyingPhotos) cancelledResult?.success(emptyList<Map<String, Any>>())
        result.success(null)
    }

    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != PICK_PHOTOS_REQUEST) return
        val result = pendingPickResult ?: return
        val pickId = activePickId ?: return
        if (resultCode != RESULT_OK || data == null) {
            pendingPickResult = null
            activePickId = null
            result.success(emptyList<Map<String, Any>>())
            return
        }

        val uris = buildList {
            data.clipData?.let { clip ->
                for (index in 0 until clip.itemCount) add(clip.getItemAt(index).uri)
            }
            data.data?.let(::add)
        }.distinct().take(50)
        copyingPhotos = true
        sendPickProgress(0, uris.size, pickId)
        Thread {
            val photos = mutableListOf<Map<String, Any>>()
            for ((index, uri) in uris.withIndex()) {
                if (activePickId != pickId) break
                runCatching { copyPickedPhoto(uri) }.onSuccess(photos::add)
                sendPickProgress(index + 1, uris.size, pickId)
            }
            runOnUiThread {
                copyingPhotos = false
                if (activePickId != pickId) {
                    photos.forEach { (it["path"] as? String)?.let(::File)?.delete() }
                    pendingPickResult = null
                    result.success(emptyList<Map<String, Any>>())
                    return@runOnUiThread
                }
                pendingPickResult = null
                activePickId = null
                result.success(photos)
            }
        }.start()
    }

    private fun sendPickProgress(processed: Int, total: Int, pickId: Long) = runOnUiThread {
        if (activePickId == pickId) {
            photosChannel.invokeMethod("pickProgress", mapOf("processed" to processed, "total" to total))
        }
    }

    private fun copyPickedPhoto(uri: Uri): Map<String, Any> {
        val name = contentResolver.query(uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)
            ?.use { cursor ->
                if (cursor.moveToFirst()) cursor.getString(0) else null
            }?.substringAfterLast('/') ?: "photo.jpg"
        val directory = File(cacheDir, "picked_photos").apply { mkdirs() }
        val safeName = name.replace(Regex("[\\\\/:*?\"<>|\\p{Cntrl}]"), "_")
        val output = File(directory, "photo_${UUID.randomUUID()}_${safeName}")
        try {
            contentResolver.openInputStream(uri).use { input ->
                requireNotNull(input) { "unable to open selected photo" }
                output.outputStream().use { input.copyTo(it) }
            }
        } catch (error: Exception) {
            output.delete()
            throw error
        }
        return mapOf("path" to output.absolutePath, "name" to name, "size" to output.length())
    }

    companion object {
        private const val PICK_PHOTOS_REQUEST = 7134
    }
}
