package androidmanager.media;

#if android
import lime.system.JNI;
#end

enum abstract MediaType(String) to String {
    var Images = "android.permission.READ_MEDIA_IMAGES";
    var Video = "android.permission.READ_MEDIA_VIDEO";
    var Audio = "android.permission.READ_MEDIA_AUDIO";
    var VisualUserSelected = "android.permission.READ_MEDIA_VISUAL_USER_SELECTED";
    var ReadStorage = "android.permission.READ_EXTERNAL_STORAGE";
    var WriteStorage = "android.permission.WRITE_EXTERNAL_STORAGE";
}

typedef PermissionResult = {
    var granted:Bool;
    var grantedList:Array<String>;
    var deniedList:Array<String>;
}

class Media {

    public static var onPermissionResult:(result:PermissionResult)->Void = null;

    #if android
    private static var _initialized:Bool = false;

    private static var _init:Dynamic = null;
    private static var _setCallback:Dynamic = null;
    private static var _getApiLevel:Dynamic = null;
    private static var _getMediaPermissions:Dynamic = null;
    private static var _hasPermission:Dynamic = null;
    private static var _hasPermissions:Dynamic = null;
    private static var _hasAll:Dynamic = null;
    private static var _requestPermission:Dynamic = null;
    private static var _requestPermissions:Dynamic = null;
    private static var _requestAll:Dynamic = null;
    private static var _shouldShowRationale:Dynamic = null;
    private static var _isPermanentlyDenied:Dynamic = null;
    private static var _wasPreviouslyRequested:Dynamic = null;

    private static var _callbackObj = {
        onPermissionResult: function(granted:Bool, grantedList:Dynamic, deniedList:Dynamic):Void {
            if (Media.onPermissionResult == null)
                return;

            Media.onPermissionResult({
                granted: granted,
                grantedList: grantedList != null
                    ? (cast grantedList : Array<Dynamic>).map(p -> Std.string(p))
                    : [],
                deniedList: deniedList != null
                    ? (cast deniedList : Array<Dynamic>).map(p -> Std.string(p))
                    : []
            });
        }
    };
    #end

    public static function init():Void {
        #if android
        if (_initialized)
            return;

        if (_init == null)
            _init = JNI.createStaticMethod(
                "androidmanager/MediaManager", "init", "()V"
            );

        if (_setCallback == null)
            _setCallback = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "setPermissionCallback",
                "(Lorg/haxe/lime/HaxeObject;)V"
            );

        _init();
        _setCallback(_callbackObj);
        _initialized = true;
        #end
    }

    public static function getApiLevel():Int {
        #if android
        if (_getApiLevel == null)
            _getApiLevel = JNI.createStaticMethod(
                "androidmanager/MediaManager", "getApiLevel", "()I"
            );

        return _getApiLevel();
        #else
        return 0;
        #end
    }

    public static function getMediaPermissions():Array<String> {
        #if android
        if (_getMediaPermissions == null)
            _getMediaPermissions = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "getMediaPermissions",
                "()[Ljava/lang/String;"
            );

        var result:Dynamic = _getMediaPermissions();
        return result != null
            ? (cast result : Array<Dynamic>).map(p -> Std.string(p))
            : [];
        #else
        return [];
        #end
    }

    public static function hasPermission(type:MediaType):Bool {
        #if android
        if (_hasPermission == null)
            _hasPermission = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "hasPermission",
                "(Ljava/lang/String;)Z"
            );

        return _hasPermission((type : String));
        #else
        return false;
        #end
    }

    public static function hasPermissions(types:Array<MediaType>):Bool {
        #if android
        if (_hasPermissions == null)
            _hasPermissions = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "hasPermissions",
                "([Ljava/lang/String;)Z"
            );

        return _hasPermissions(types.map(t -> (t : String)));
        #else
        return false;
        #end
    }

    public static function hasAll():Bool {
        #if android
        if (_hasAll == null)
            _hasAll = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "hasAllMediaPermissions",
                "()Z"
            );

        return _hasAll();
        #else
        return false;
        #end
    }

    public static function requestPermission(type:MediaType):Void {
        #if android
        if (_requestPermission == null)
            _requestPermission = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "requestPermission",
                "(Ljava/lang/String;)V"
            );

        _requestPermission((type : String));
        #end
    }

    public static function requestPermissions(types:Array<MediaType>):Void {
        #if android
        if (_requestPermissions == null)
            _requestPermissions = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "requestPermissions",
                "([Ljava/lang/String;)V"
            );

        _requestPermissions(types.map(t -> (t : String)));
        #end
    }

    public static function requestAll():Void {
        #if android
        if (_requestAll == null)
            _requestAll = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "requestAllMediaPermissions",
                "()V"
            );

        _requestAll();
        #end
    }

    public static function shouldShowRationale(type:MediaType):Bool {
        #if android
        if (_shouldShowRationale == null)
            _shouldShowRationale = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "shouldShowRationale",
                "(Ljava/lang/String;)Z"
            );

        return _shouldShowRationale((type : String));
        #else
        return false;
        #end
    }

    public static function isPermanentlyDenied(type:MediaType):Bool {
        #if android
        if (_isPermanentlyDenied == null)
            _isPermanentlyDenied = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "isPermanentlyDenied",
                "(Ljava/lang/String;)Z"
            );

        return _isPermanentlyDenied((type : String));
        #else
        return false;
        #end
    }

    public static function wasPreviouslyRequested(type:MediaType):Bool {
        #if android
        if (_wasPreviouslyRequested == null)
            _wasPreviouslyRequested = JNI.createStaticMethod(
                "androidmanager/MediaManager",
                "wasPreviouslyRequested",
                "(Ljava/lang/String;)Z"
            );

        return _wasPreviouslyRequested((type : String));
        #else
        return false;
        #end
    }
}