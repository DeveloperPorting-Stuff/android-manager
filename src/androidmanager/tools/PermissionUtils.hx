package androidmanager.tools;

#if android
import androidmanager.jni.JNICache;
#end

/**
 * Utility class for managing Android permissions via JNI.
 * Allows checking and requesting runtime permissions on Android devices.
 * @see https://developer.android.com/guide/topics/permissions/overview
 */
class PermissionUtils {

    #if android
    private static var _hasPermission:Dynamic = null;
    private static var _requestPermission:Dynamic = null;
    private static var _hasPermissions:Dynamic = null;
    private static var _requestPermissions:Dynamic = null;

    private static function formatPermission(permission:String):String {
        if (permission.indexOf("android.permission.") == 0) return permission;
        return "android.permission." + permission;
    }
    #end

    /**
     * Checks whether the application has been granted a specific Android permission.
     * * @param permission The Android permission string (e.g., "android.permission.READ_EXTERNAL_STORAGE").
     * @return `true` if the permission is granted or if the device runs an older Android version where permissions are granted at install time. Returns `false` otherwise or if a JNI error occurs.
     */
    public static function hasPermission(permission:String):Bool {
        #if android
        permission = formatPermission(permission);
        if (_hasPermission == null) {
            try {
                _hasPermission = JNICache.getStaticMethod("java/androidmanager/PermissionManager", "hasPermission", "(Ljava/lang/String;)Z");
            } catch(e:Dynamic) {
                trace("JNI ERROR (hasPermission): " + e);
                return false;
            }
        }
        return _hasPermission != null ? _hasPermission(permission) : false;
        #else
        return false;
        #end
    }

    /**
     * Triggers the native Android permission request dialog for a single permission.
     * * @param permission The Android permission string to request.
     */
    public static function requestPermission(permission:String):Void {
        #if android
        permission = formatPermission(permission);
        if (_requestPermission == null) {
            try {
                _requestPermission = JNICache.getStaticMethod("java/androidmanager/PermissionManager", "requestPermission", "(Ljava/lang/String;)V");
            } catch(e:Dynamic) {
                trace("JNI ERROR (requestPermission): " + e);
                return;
            }
        }
        if (_requestPermission != null) _requestPermission(permission);
        #end
    }

    /**
     * Checks whether the application has been granted a list of specific Android permissions.
     * * @param permissions An array of Android permission strings to check.
     * @return `true` if ALL permissions in the array are granted, `false` otherwise.
     */
    public static function hasPermissions(permissions:Array<String>):Bool {
        #if android
        var formattedPermissions = [];
        for (p in permissions) {
            formattedPermissions.push(formatPermission(p));
        }
        permissions = formattedPermissions;

        if (_hasPermissions == null) {
            try {
                _hasPermissions = JNICache.getStaticMethod("java/androidmanager/PermissionManager", "hasPermissions", "([Ljava/lang/String;)Z");
            } catch(e:Dynamic) {
                trace("JNI ERROR (hasPermissions): " + e);
                return false;
            }
        }
        return _hasPermissions != null ? _hasPermissions(permissions) : false;
        #else
        return false;
        #end
    }

    /**
     * Triggers the native Android permission request dialog for multiple permissions at once.
     * * @param permissions An array of Android permission strings to request.
     */
    public static function requestPermissions(permissions:Array<String>):Void {
        #if android
        var formattedPermissions = [];
        for (p in permissions) {
            formattedPermissions.push(formatPermission(p));
        }
        permissions = formattedPermissions;

        if (_requestPermissions == null) {
            try {
                _requestPermissions = JNICache.getStaticMethod("java/androidmanager/PermissionManager", "requestPermissions", "([Ljava/lang/String;)V");
            } catch(e:Dynamic) {
                trace("JNI ERROR (requestPermissions): " + e);
                return;
            }
        }
        if (_requestPermissions != null) _requestPermissions(permissions);
        #end
    }
}