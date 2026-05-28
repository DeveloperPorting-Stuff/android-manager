package androidmanager.content;

#if android
import lime.system.JNI;
#end

class Context {

    #if android
    private static var _getExternalFilesDir:Dynamic = null;
    private static var _getInternalFilesDir:Dynamic = null;
    private static var _isExternalStorageAvailable:Dynamic = null;
    #end

    public static function getExternalFilesDir(type:String = null):Null<String> {
        #if android
        if (_getExternalFilesDir == null)
            _getExternalFilesDir = JNI.createStaticMethod(
                "java/androidmanager/ContextManager",
                "getExternalFilesDir",
                "(Ljava/lang/String;)Ljava/lang/String;"
            );

        var path:Null<String> = _getExternalFilesDir(type == null ? "" : type);
        if (path != null)
            return path;

        return getInternalFilesDir();
        #else
        return null;
        #end
    }

    public static function getInternalFilesDir():Null<String> {
        #if android
        if (_getInternalFilesDir == null)
            _getInternalFilesDir = JNI.createStaticMethod(
                "java/androidmanager/ContextManager",
                "getInternalFilesDir",
                "()Ljava/lang/String;"
            );

        return _getInternalFilesDir();
        #else
        return null;
        #end
    }

    public static function isExternalStorageAvailable():Bool {
        #if android
        if (_isExternalStorageAvailable == null)
            _isExternalStorageAvailable = JNI.createStaticMethod(
                "java/androidmanager/ContextManager",
                "isExternalStorageAvailable",
                "()Z"
            );

        return _isExternalStorageAvailable();
        #else
        return false;
        #end
    }
}