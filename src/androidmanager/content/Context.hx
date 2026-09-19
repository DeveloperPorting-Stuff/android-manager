package androidmanager.content;

#if android
import androidmanager.jni.JNICache;
#end

/**
 * Interface to global information about an application environment.
 * This class is intentionally left empty. Use the nested `Storage` and `App` classes below.
 * @see https://developer.android.com/reference/android/content/Context
 */
class Context {
    /**
     * Returns the absolute path to the directory on the filesystem where files 
     * created with openFileOutput(String, int) are stored. This is internal private storage.
     */
    public static var internalFilesDir(get, never):Null<String>;
    private static function get_internalFilesDir():Null<String> {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getInternalFilesDir", "()Ljava/lang/String;");
        return func != null ? func() : null;
        #else
        return null;
        #end
    }

    /**
     * Returns the absolute path to the application specific cache directory on the filesystem.
     */
    public static var cacheDir(get, never):Null<String>;
    private static function get_cacheDir():Null<String> {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getCacheDir", "()Ljava/lang/String;");
        return func != null ? func() : null;
        #else
        return null;
        #end
    }

    /**
     * Returns the absolute path to the primary shared/external storage directory where 
     * the application's OBB files (if there are any) can be found.
     */
    public static var obbDir(get, never):Null<String>;
    private static function get_obbDir():Null<String> {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getObbDir", "()Ljava/lang/String;");
        return func != null ? func() : null;
        #else
        return null;
        #end
    }

    /**
     * Returns the absolute path to the primary shared/external storage directory where 
     * the application's external data (Android/data/com.package.name) is stored.
     */
    public static var externalDataDir(get, never):Null<String>;
    private static function get_externalDataDir():Null<String> {
        var obb = obbDir;
        if (obb != null) return StringTools.replace(obb, "/obb/", "/data/");
        
        return null;
    }

    /**
     * Checks whether the primary external storage is available for reading and writing.
     */
    public static var externalStorageAvailable(get, never):Bool;
    private static function get_externalStorageAvailable():Bool {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "isExternalStorageAvailable", "()Z");
        return func != null ? func() : false;
        #else
        return false;
        #end
    }

    /**
     * Returns the absolute path to the directory on the filesystem where files 
     * are stored. This is internal private storage.
     */
    public static var dataDir(get, never):String;
    private static function get_dataDir():String {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getDataDir", "()Ljava/lang/String;");
        return func != null ? func() : "";
        #else
        return "";
        #end
    }

    /**
     * Returns the absolute path to the directory on the filesystem where all 
     * private files belonging to this app are stored.
     */
    public static var codeCacheDir(get, never):String;
    private static function get_codeCacheDir():String {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getCodeCacheDir", "()Ljava/lang/String;");
        return func != null ? func() : "";
        #else
        return "";
        #end
    }

    /**
     * Returns the absolute path to a directory on the filesystem where files 
     * created by the app should be stored and will NOT be automatically backed up.
     */
    public static var noBackupFilesDir(get, never):String;
    private static function get_noBackupFilesDir():String {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getNoBackupFilesDir", "()Ljava/lang/String;");
        return func != null ? func() : "";
        #else
        return "";
        #end
    }

    /**
     * Returns absolute paths to application-specific directories on all external storage devices.
     */
    public static var externalCacheDirs(get, never):Array<String>;
    private static function get_externalCacheDirs():Array<String> {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getExternalCacheDirs", "()Ljava/lang/String;");
        var res:String = func != null ? func() : "";
        return res == "" ? [] : res.split(";");
        #else
        return [];
        #end
    }

    /**
     * Returns the absolute path to the directory on the primary shared/external 
     * storage device where the application can place persistent files it owns.
     * @param type The type of files directory to return (e.g., "Music", "Download"). 
     */
    public static function getExternalFilesDir(type:String = null):Null<String> {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getExternalFilesDir", "(Ljava/lang/String;)Ljava/lang/String;");
        if (func != null) {
            var path:Null<String> = func(type == null ? "" : type);
            if (path != null) return path;
        }
        return internalFilesDir;
        #else
        return null;
        #end
    }

    /**
     * Returns the absolute path to the directory in which a database is stored.
     * @param name The name of the database file.
     */
    public static function getDatabasePath(name:String):String {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getDatabasePath", "(Ljava/lang/String;)Ljava/lang/String;");
        return func != null ? func(name) : "";
        #else
        return "";
        #end
    }

    /**
     * Returns the absolute path to the directory in which a file stream is stored.
     * @param name The name of the file.
     */
    public static function getFileStreamPath(name:String):String {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getFileStreamPath", "(Ljava/lang/String;)Ljava/lang/String;");
        return func != null ? func(name) : "";
        #else
        return "";
        #end
    }

    /**
     * Returns absolute paths to application-specific directories on all external storage devices.
     * @param type The type of files directory to return.
     */
    public static function getExternalFilesDirs(type:String):Array<String> {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$Storage", "getExternalFilesDirs", "(Ljava/lang/String;)Ljava/lang/String;");
        var res:String = func != null ? func(type) : "";
        return res == "" ? [] : res.split(";");
        #else
        return [];
        #end
    }
}

/**
 * Provides access to application-specific information and metadata.
 */
class App {

    /**
     * Returns the name of this application's package.
     * @return The package name of the application (e.g., "com.example.app"), or "Unknown" if unavailable.
     */
    public static var packageName(get, never):String;
    private static function get_packageName():String {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/ContextManager$App", "getPackageName", "()Ljava/lang/String;");
        return func != null ? func() : "Unknown";
        #else
        return "Unknown";
        #end
    }
}