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

    private static function formatPermission(permission:String):Null<String> {
        if (permission == null)
            return null;

        permission = StringTools.trim(permission);
        if (permission.length == 0)
            return null;

        return permission.indexOf("android.permission.") == 0
            ? permission
            : "android.permission." + permission;
    }

    private static function formatPermissions(permissions:Array<String>):Array<String> {
        var formatted:Array<String> = [];
        if (permissions == null)
            return formatted;

        for (permission in permissions) {
            var formattedPermission = formatPermission(permission);
            if (formattedPermission != null && formatted.indexOf(formattedPermission) == -1)
                formatted.push(formattedPermission);
        }

        return formatted;
    }
    #end

    /**
     * Checks whether the application has been granted a specific Android permission.
     * @param permission The Android permission string (e.g., "android.permission.READ_EXTERNAL_STORAGE").
     * @return `true` if the permission is granted or if the device runs an older Android version where permissions are granted at install time. Returns `false` otherwise or if a JNI error occurs.
     */
    public static function hasPermission(permission:String):Bool {
        #if android
        var formattedPermission = formatPermission(permission);
        if (formattedPermission == null)
            return false;

        if (_hasPermission == null) {
            try {
                _hasPermission = JNICache.getStaticMethod("java/androidmanager/PermissionManager", "hasPermission", "(Ljava/lang/String;)Z");
            } catch(e:Dynamic) {
                trace("JNI ERROR (hasPermission): " + e);
                return false;
            }
        }
        return _hasPermission != null ? _hasPermission(formattedPermission) : false;
        #else
        return false;
        #end
    }

    /**
     * Triggers the native Android permission request dialog for a single permission.
     * @param permission The Android permission string to request.
     */
    public static function requestPermission(permission:String):Void {
        #if android
        var formattedPermission = formatPermission(permission);
        if (formattedPermission == null)
            return;

        if (_requestPermission == null) {
            try {
                _requestPermission = JNICache.getStaticMethod("java/androidmanager/PermissionManager", "requestPermission", "(Ljava/lang/String;)V");
            } catch(e:Dynamic) {
                trace("JNI ERROR (requestPermission): " + e);
                return;
            }
        }
        if (_requestPermission != null) _requestPermission(formattedPermission);
        #end
    }

    /**
     * Checks whether the application has been granted a list of specific Android permissions.
     * @param permissions An array of Android permission strings to check.
     * @return `true` if ALL permissions in the array are granted, `false` otherwise.
     */
    public static function hasPermissions(permissions:Array<String>):Bool {
        #if android
        var formattedPermissions = formatPermissions(permissions);
        if (formattedPermissions.length == 0)
            return false;

        if (_hasPermissions == null) {
            try {
                _hasPermissions = JNICache.getStaticMethod("java/androidmanager/PermissionManager", "hasPermissions", "([Ljava/lang/String;)Z");
            } catch(e:Dynamic) {
                trace("JNI ERROR (hasPermissions): " + e);
                return false;
            }
        }
        return _hasPermissions != null ? _hasPermissions(formattedPermissions) : false;
        #else
        return false;
        #end
    }

    /**
     * Triggers the native Android permission request dialog for multiple permissions at once.
     * @param permissions An array of Android permission strings to request.
     */
    public static function requestPermissions(permissions:Array<String>):Void {
        #if android
        var formattedPermissions = formatPermissions(permissions);
        if (formattedPermissions.length == 0)
            return;

        if (_requestPermissions == null) {
            try {
                _requestPermissions = JNICache.getStaticMethod("java/androidmanager/PermissionManager", "requestPermissions", "([Ljava/lang/String;)V");
            } catch(e:Dynamic) {
                trace("JNI ERROR (requestPermissions): " + e);
                return;
            }
        }
        if (_requestPermissions != null) _requestPermissions(formattedPermissions);
        #end
    }
}