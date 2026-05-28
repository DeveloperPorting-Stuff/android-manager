package androidmanager.media;

#if android
import lime.system.JNI;
#end

enum abstract MediaType(String) to String {
    var Images = "android.permission.READ_MEDIA_IMAGES";
    var Video = "android.permission.READ_MEDIA_VIDEO";
    var Audio = "android.permission.READ_MEDIA_AUDIO";
    var ReadStorage = "android.permission.READ_EXTERNAL_STORAGE";
    var WriteStorage = "android.permission.WRITE_EXTERNAL_STORAGE";
}

class Media {

    #if android
    private static var _hasPermission:Dynamic = null;
    private static var _hasPermissions:Dynamic = null;
    private static var _requestPermission:Dynamic = null;
    private static var _requestPermissions:Dynamic = null;
    #end

    public static function hasPermission(type:MediaType):Bool {
        #if android
        if (_hasPermission == null)
            _hasPermission = JNI.createStaticMethod(
                "androidmanager/PermissionManager",
                "hasPermission",
                "(Ljava/lang/String;)Z"
            );

        return _hasPermission((type : String));
        #else
        return false;
        #end
    }

    public static function requestPermission(type:MediaType):Void {
        #if android
        if (_requestPermission == null)
            _requestPermission = JNI.createStaticMethod(
                "androidmanager/PermissionManager",
                "requestPermission",
                "(Ljava/lang/String;)V"
            );

        _requestPermission((type : String));
        #end
    }

    public static function hasAll():Bool {
        #if android
        if (_hasPermissions == null)
            _hasPermissions = JNI.createStaticMethod(
                "androidmanager/PermissionManager",
                "hasPermissions",
                "([Ljava/lang/String;)Z"
            );

        return _hasPermissions([
            (Images : String),
            (Video : String),
            (Audio : String)
        ]);
        #else
        return false;
        #end
    }

    public static function requestAll():Void {
        #if android
        if (_requestPermissions == null)
            _requestPermissions = JNI.createStaticMethod(
                "androidmanager/PermissionManager",
                "requestPermissions",
                "([Ljava/lang/String;)V"
            );

        _requestPermissions([
            (Images : String),
            (Video : String),
            (Audio : String)
        ]);
        #end
    }
}