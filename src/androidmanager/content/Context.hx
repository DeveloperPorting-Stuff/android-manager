package androidmanager.content;

#if android
import androidmanager.jni.JNICache;
#end

/**
 * Interface to global information about an application environment.
 * This class is intentionally left empty. Use the nested `Storage` and `App` classes below.
 *  @see https://developer.android.com/reference/android/content/Context
 */

class Context {

    /**
     * Returns the absolute path to the directory on the primary shared/external 
     * storage device where the application can place persistent files it owns.
     * * @param type The type of files directory to return (e.g., "Music", "Download"). 
     * Pass null or an empty string for the root files directory.
     * @return The absolute path of the directory, or the internal path if external is unavailable.
     */
    public static function getExternalFilesDir(type:String = null):Null<String> {
        #if android
        var func = JNICache.getStaticMethod(
            "java/androidmanager/ContextManager$Storage", 
            "getExternalFilesDir",
            "(Ljava/lang/String;)Ljava/lang/String;"
        );

        if (func != null) {
            var path:Null<String> = func(type == null ? "" : type);
            if (path != null) return path;
        }
        return getInternalFilesDir();
        #else
        return null;
        #end
    }

    /**
     * Returns the absolute path to the directory on the filesystem where files 
     * created with openFileOutput(String, int) are stored. This is internal private storage.
     * * @return The absolute path to the internal files directory, or null if unavailable.
     */

    public static function getInternalFilesDir():Null<String> {
        #if android
        var func = JNICache.getStaticMethod(
            "java/androidmanager/ContextManager$Storage",
            "getInternalFilesDir",
            "()Ljava/lang/String;"
        );
        return func != null ? func() : null;
        #else
        return null;
        #end
    }

    /**
     * Returns the absolute path to the application specific cache directory on the filesystem.
     * The system will automatically delete files in this directory as disk space is needed elsewhere on the device.
     * * @return The absolute path to the cache directory, or null if unavailable.
     */
    public static function getCacheDir():Null<String> {
        #if android
        var func = JNICache.getStaticMethod(
            "java/androidmanager/ContextManager$Storage",
            "getCacheDir",
            "()Ljava/lang/String;"
        );
        return func != null ? func() : null;
        #else
        return null;
        #end
    }

    /**
     * Returns the absolute path to the primary shared/external storage directory where 
     * the application's OBB files (if there are any) can be found.
     * * @return The absolute path to the OBB directory, or null if unavailable.
     */
    public static function getObbDir():Null<String> {
        #if android
        var func = JNICache.getStaticMethod(
            "java/androidmanager/ContextManager$Storage",
            "getObbDir",
            "()Ljava/lang/String;"
        );
        return func != null ? func() : null;
        #else
        return null;
        #end
    }

    /**
     * Checks whether the primary external storage is available for reading and writing.
     * * @return True if external storage is mounted and writable, false otherwise.
     */
    public static function isExternalStorageAvailable():Bool {
        #if android
        var func = JNICache.getStaticMethod(
            "java/androidmanager/ContextManager$Storage",
            "isExternalStorageAvailable",
            "()Z"
        );
        return func != null ? func() : false;
        #else
        return false;
        #end
    }

    /**
     * Returns the absolute path to the directory on the filesystem where files 
     * are stored. This is internal private storage.
     */
    public static function getDataDir():String {
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getDataDir", "()Ljava/lang/String;");
        return func != null ? func() : "";
    }

    /**
     * Returns the absolute path to the directory on the filesystem where all 
     * private files belonging to this app are stored.
     */
    public static function getCodeCacheDir():String {
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getCodeCacheDir", "()Ljava/lang/String;");
        return func != null ? func() : "";
    }

    /**
     * Returns the absolute path to a directory on the filesystem where files 
     * created by the app should be stored and will NOT be automatically backed up.
     */
    public static function getNoBackupFilesDir():String {
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getNoBackupFilesDir", "()Ljava/lang/String;");
        return func != null ? func() : "";
    }

    /**
     * Returns the absolute path to the directory in which a database is stored.
     * @param name The name of the database file.
     */
    public static function getDatabasePath(name:String):String {
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getDatabasePath", "(Ljava/lang/String;)Ljava/lang/String;");
        return func != null ? func(name) : "";
    }

    /**
     * Returns the absolute path to the directory in which a file stream is stored.
     * @param name The name of the file.
     */
    public static function getFileStreamPath(name:String):String {
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getFileStreamPath", "(Ljava/lang/String;)Ljava/lang/String;");
        return func != null ? func(name) : "";
    }

    /**
     * Returns absolute paths to application-specific directories on all external storage devices.
     * @return An Array of strings containing the paths.
     */
    public static function getExternalCacheDirs():Array<String> {
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getExternalCacheDirs", "()Ljava/lang/String;");
        var res:String = func != null ? func() : "";
        return res == "" ? [] : res.split(";");
    }

    /**
     * Returns absolute paths to application-specific directories on all external storage devices.
     * @param type The type of files directory to return.
     * @return An Array of strings containing the paths.
     */
    public static function getExternalFilesDirs(type:String):Array<String> {
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getExternalFilesDirs", "(Ljava/lang/String;)Ljava/lang/String;");
        var res:String = func != null ? func(type) : "";
        return res == "" ? [] : res.split(";");
    }
}

/**
 * Provides access to application-specific information and metadata.
 */
class App {

    /**
     * Returns the name of this application's package.
     * * @return The package name of the application (e.g., "com.example.app"), or "Unknown" if unavailable.
     * @see https://developer.android.com/reference/android/content/pm/PackageManager
     */
    public static function getPackageName():String {
        #if android
        var func = JNICache.getStaticMethod(
            "java/androidmanager/ContextManager$App",
            "getPackageName",
            "()Ljava/lang/String;"
        );
        return func != null ? func() : "Unknown";
        #else
        return "Unknown";
        #end
    }
}