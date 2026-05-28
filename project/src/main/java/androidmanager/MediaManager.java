package androidmanager;

import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.os.Build;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

public class MediaManager extends Extension {

    private static final int REQUEST_CODE = 2048;
    private static final String PREFS_NAME = "androidmanager_media";
    private static final String PREFS_REQUESTED_PREFIX = "requested_";

    private static MediaManager _instance = null;
    private static HaxeObject _permissionCallback = null;

    public static void init() {
        if (_instance != null)
            return;

        _instance = new MediaManager();
        Extension.registeredExtensions.add(_instance);
    }

    public static void setPermissionCallback(HaxeObject callback) {
        _permissionCallback = callback;
    }

    public static int getApiLevel() {
        return Build.VERSION.SDK_INT;
    }

    public static String[] getMediaPermissions() {
        if (Build.VERSION.SDK_INT >= 34) {
            return new String[]{
                "android.permission.READ_MEDIA_IMAGES",
                "android.permission.READ_MEDIA_VIDEO",
                "android.permission.READ_MEDIA_AUDIO",
                "android.permission.READ_MEDIA_VISUAL_USER_SELECTED"
            };
        } else if (Build.VERSION.SDK_INT >= 33) {
            return new String[]{
                "android.permission.READ_MEDIA_IMAGES",
                "android.permission.READ_MEDIA_VIDEO",
                "android.permission.READ_MEDIA_AUDIO"
            };
        } else {
            return new String[]{
                "android.permission.READ_EXTERNAL_STORAGE",
                "android.permission.WRITE_EXTERNAL_STORAGE"
            };
        }
    }

    public static boolean hasPermission(String permission) {
        if (Extension.mainActivity == null || permission == null)
            return false;

        return ContextCompat.checkSelfPermission(Extension.mainActivity, permission)
            == PackageManager.PERMISSION_GRANTED;
    }

    public static boolean hasPermissions(String[] permissions) {
        if (Extension.mainActivity == null || permissions == null)
            return false;

        for (String permission : permissions) {
            if (permission == null)
                continue;
            if (ContextCompat.checkSelfPermission(Extension.mainActivity, permission)
                    != PackageManager.PERMISSION_GRANTED)
                return false;
        }

        return true;
    }

    public static boolean hasAllMediaPermissions() {
        return hasPermissions(getMediaPermissions());
    }

    public static void requestPermission(final String permission) {
        if (Extension.mainActivity == null || permission == null)
            return;

        markAsRequested(permission);

        Extension.mainActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                ActivityCompat.requestPermissions(
                    Extension.mainActivity,
                    new String[]{ permission },
                    REQUEST_CODE
                );
            }
        });
    }

    public static void requestPermissions(final String[] permissions) {
        if (Extension.mainActivity == null || permissions == null || permissions.length == 0)
            return;

        for (String permission : permissions)
            markAsRequested(permission);

        Extension.mainActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                ActivityCompat.requestPermissions(
                    Extension.mainActivity,
                    permissions,
                    REQUEST_CODE
                );
            }
        });
    }

    public static void requestAllMediaPermissions() {
        requestPermissions(getMediaPermissions());
    }

    public static boolean shouldShowRationale(String permission) {
        if (Extension.mainActivity == null || permission == null)
            return false;

        return ActivityCompat.shouldShowRequestPermissionRationale(
            Extension.mainActivity, permission
        );
    }

    public static boolean isPermanentlyDenied(String permission) {
        if (Extension.mainActivity == null || permission == null)
            return false;

        if (!wasPreviouslyRequested(permission))
            return false;

        boolean denied = ContextCompat.checkSelfPermission(Extension.mainActivity, permission)
            != PackageManager.PERMISSION_GRANTED;
        boolean noRationale = !ActivityCompat.shouldShowRequestPermissionRationale(
            Extension.mainActivity, permission
        );

        return denied && noRationale;
    }

    public static boolean wasPreviouslyRequested(String permission) {
        if (Extension.mainActivity == null || permission == null)
            return false;

        SharedPreferences prefs = Extension.mainActivity
            .getSharedPreferences(PREFS_NAME, 0);

        return prefs.getBoolean(PREFS_REQUESTED_PREFIX + permission.replace(".", "_"), false);
    }

    private static void markAsRequested(String permission) {
        if (Extension.mainActivity == null || permission == null)
            return;

        Extension.mainActivity
            .getSharedPreferences(PREFS_NAME, 0)
            .edit()
            .putBoolean(PREFS_REQUESTED_PREFIX + permission.replace(".", "_"), true)
            .apply();
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        if (requestCode != REQUEST_CODE || _permissionCallback == null)
            return false;

        final boolean allGranted = grantResults.length > 0
            && allResultsGranted(grantResults);
        final String[] grantedList = buildFilteredList(permissions, grantResults, true);
        final String[] deniedList = buildFilteredList(permissions, grantResults, false);

        Extension.callbackHandler.post(new Runnable() {
            @Override
            public void run() {
                _permissionCallback.call("onPermissionResult",
                    new Object[]{ allGranted, grantedList, deniedList });
            }
        });

        return true;
    }

    private static boolean allResultsGranted(int[] results) {
        for (int result : results)
            if (result != PackageManager.PERMISSION_GRANTED)
                return false;
        return true;
    }

    private static String[] buildFilteredList(String[] permissions, int[] results, boolean granted) {
        int count = 0;
        for (int result : results)
            if ((result == PackageManager.PERMISSION_GRANTED) == granted)
                count++;

        String[] list = new String[count];
        int i = 0;
        for (int j = 0; j < results.length; j++)
            if ((results[j] == PackageManager.PERMISSION_GRANTED) == granted)
                list[i++] = permissions[j];

        return list;
    }
}