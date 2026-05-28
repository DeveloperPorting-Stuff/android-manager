package androidmanager.content;

#if android
import lime.system.JNI;
#end

/**
 * Interface to global information about an application environment.
 * @see https://developer.android.com/reference/android/content/Context
 */
class Context {

    #if android
    private static var _getExternalFilesDir:Dynamic = null;
    private static var _getInternalFilesDir:Dynamic = null;
    private static var _isExternalStorageAvailable:Dynamic = null;
    #end

    /**
     * Returns the absolute path to the directory on the primary shared/external
     * storage device where the application can place persistent files it owns.
     * (e.g., "/storage/emulated/0/Android/data/com.your.package/files")
     * @param type The type of files directory to return (e.g., Environment.DIRECTORY_MUSIC).
     *             Pass null for the root files directory.
     * @return The absolute path of the directory, or null if unavailable.
     */
    public static function getExternalFilesDir(type:String = null):Null<String> {
        #if android
        if (_getExternalFilesDir == null)
            _getExternalFilesDir = JNI.createStaticMethod(
                "androidmanager/ContextManager",
                "getExternalFilesDir",
                "(Ljava/lang/String;)Ljava/lang/String;"
            );

        return _getExternalFilesDir(type);
        #else
        return null;
        #end
    }

    /**
     * Returns the absolute path to the directory on the internal storage
     * where the application can place persistent files it owns.
     * @return The absolute path of the directory, or null if unavailable.
     */
    public static function getInternalFilesDir():Null<String> {
        #if android
        if (_getInternalFilesDir == null)
            _getInternalFilesDir = JNI.createStaticMethod(
                "androidmanager/ContextManager",
                "getInternalFilesDir",
                "()Ljava/lang/String;"
            );

        return _getInternalFilesDir();
        #else
        return null;
        #end
    }

    /**
     * Returns whether the primary external storage is available for reading and writing.
     * @return true if external storage is mounted and writable.
     */
    public static function isExternalStorageAvailable():Bool {
        #if android
        if (_isExternalStorageAvailable == null)
            _isExternalStorageAvailable = JNI.createStaticMethod(
                "androidmanager/ContextManager",
                "isExternalStorageAvailable",
                "()Z"
            );

        return _isExternalStorageAvailable();
        #else
        return false;
        #end
    }
}