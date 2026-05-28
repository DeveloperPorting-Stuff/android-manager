package androidmanager.tools;

#if android
import lime.system.JNI;
#end

class PermissionUtils {
    
    private static var _hasPermission:Dynamic = null;
    private static var _requestPermission:Dynamic = null;

    /**
     * Checks whether the application has been granted a specific permission.
     * @param permission The Android permission string.
     * @return True if permission is granted, false otherwise.
     */
    public static function hasPermission(permission:String):Bool {
        #if android
        if (_hasPermission == null) {
            _hasPermission = JNI.createStaticMethod("androidmanager/java/PermissionManager", "hasPermission", "(Ljava/lang/String;)Z");
        }
        
        if (_hasPermission != null) {
            return _hasPermission(permission);
        }
        #end
        return false;
    }

    /**
     * Triggers the native Android permission request dialog.
     * @param permission The Android permission string to request.
     */
    public static function requestPermission(permission:String):Void {
        #if android
        if (_requestPermission == null) {
            _requestPermission = JNI.createStaticMethod("androidmanager/java/PermissionManager", "requestPermission", "(Ljava/lang/String;)V");
        }
        
        if (_requestPermission != null) {
            _requestPermission(permission);
        }
        #end
    }
}
