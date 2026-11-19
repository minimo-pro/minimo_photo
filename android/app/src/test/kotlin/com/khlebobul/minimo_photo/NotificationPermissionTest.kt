package com.khlebobul.minimo_photo

import android.Manifest
import android.content.pm.PackageManager
import io.flutter.plugin.common.MethodChannel
import org.junit.Assert.*
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.Robolectric
import org.robolectric.RuntimeEnvironment
import org.robolectric.Shadows.shadowOf
import org.robolectric.annotation.Config

@RunWith(org.robolectric.RobolectricTestRunner::class)
@Config(sdk = [33], manifest = Config.NONE)
class NotificationPermissionTest {
    private fun request(activity: MainActivity, action: () -> Unit) {
        MainActivity::class.java.getDeclaredMethod("withNotificationPermission", Function0::class.java)
            .apply { isAccessible = true }.invoke(activity, action)
    }

    @Test fun denialContinuesTheOperationAndDoesNotPromptAgain() {
        val activity = Robolectric.buildActivity(MainActivity::class.java).get()
        shadowOf(RuntimeEnvironment.getApplication()).denyPermissions(Manifest.permission.POST_NOTIFICATIONS)
        var starts = 0
        request(activity) { starts++ }
        assertEquals(0, starts)
        val permission = shadowOf(activity).lastRequestedPermission
        assertArrayEquals(arrayOf(Manifest.permission.POST_NOTIFICATIONS), permission.requestedPermissions)
        activity.onRequestPermissionsResult(permission.requestCode, permission.requestedPermissions,
            intArrayOf(PackageManager.PERMISSION_DENIED))
        assertEquals(1, starts)
        request(activity) { starts++ }
        assertEquals(2, starts)
        activity.onRequestPermissionsResult(permission.requestCode, permission.requestedPermissions, intArrayOf())
        assertEquals(2, starts)
    }

    @Test fun grantContinuesTheWaitingOperation() {
        val activity = Robolectric.buildActivity(MainActivity::class.java).get()
        shadowOf(RuntimeEnvironment.getApplication()).denyPermissions(Manifest.permission.POST_NOTIFICATIONS)
        var starts = 0
        request(activity) { starts++ }
        val permission = shadowOf(activity).lastRequestedPermission
        activity.onRequestPermissionsResult(permission.requestCode, permission.requestedPermissions,
            intArrayOf(PackageManager.PERMISSION_GRANTED))
        assertEquals(1, starts)
    }

    @Test fun cancelledPickerDoesNotOpenAfterThePermissionResponse() {
        val activity = Robolectric.buildActivity(MainActivity::class.java).get()
        shadowOf(RuntimeEnvironment.getApplication()).denyPermissions(Manifest.permission.POST_NOTIFICATIONS)
        var completions = 0
        val result = object : MethodChannel.Result {
            override fun success(value: Any?) { assertEquals(emptyList<Any>(), value); completions++ }
            override fun error(code: String, message: String?, details: Any?) = fail(code)
            override fun notImplemented() = fail("not implemented")
        }
        MainActivity::class.java.getDeclaredMethod("pickPhotos", Any::class.java, MethodChannel.Result::class.java)
            .apply { isAccessible = true }.invoke(activity, mapOf("source" to "files"), result)
        val permission = shadowOf(activity).lastRequestedPermission
        val prompt = shadowOf(activity).nextStartedActivityForResult
        assertEquals(permission.requestCode, prompt.requestCode)
        assertEquals("android.content.pm.action.REQUEST_PERMISSIONS", prompt.intent.action)
        assertNull(shadowOf(activity).nextStartedActivityForResult)
        MainActivity::class.java.getDeclaredMethod("cancelPick").apply { isAccessible = true }.invoke(activity)
        assertEquals(1, completions)
        activity.onRequestPermissionsResult(permission.requestCode, permission.requestedPermissions,
            intArrayOf(PackageManager.PERMISSION_GRANTED))
        assertEquals(1, completions)
        assertNull(shadowOf(activity).nextStartedActivityForResult)
    }

    @Test fun existingPermissionStartsWithoutAnotherPrompt() {
        val activity = Robolectric.buildActivity(MainActivity::class.java).get()
        shadowOf(RuntimeEnvironment.getApplication()).grantPermissions(Manifest.permission.POST_NOTIFICATIONS)
        var starts = 0
        request(activity) { starts++ }
        assertEquals(1, starts)
        assertNull(shadowOf(activity).lastRequestedPermission)
    }

    @Test @Config(sdk = [28]) fun olderAndroidStartsWithoutAPermissionPrompt() {
        val activity = Robolectric.buildActivity(MainActivity::class.java).get()
        var starts = 0
        request(activity) { starts++ }
        assertEquals(1, starts)
        assertNull(shadowOf(activity).lastRequestedPermission)
    }
}
