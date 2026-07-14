package androidmanager.os;

#if android
import androidmanager.jni.JNICache;
import lime.system.JNI;
#end

/**
 * Standard Logcat filter levels on Android.
 */
enum abstract LogLevel(String) to String {
    var VERBOSE = "V";
    var DEBUG = "D";
    var INFO = "I";
    var WARN = "W";
    var ERROR = "E";
    var FATAL = "F";
    var SILENT = "S";
}

/**
 * Provides access to environment variables and standard directories.
 * * @see https://developer.android.com/reference/android/os/Environment
 */
class Environment {
    
    /**
     * Standard directory in which to place files that have been downloaded by the user.
     */
    public static var DIRECTORY_DOWNLOADS(get, never):String;

    /**
     * Standard directory in which to place any audio files that should be in the regular list of music for the user.
     */
    public static var DIRECTORY_MUSIC(get, never):String;

    /**
     * Standard directory in which to place pictures that are available to the user.
     */
    public static var DIRECTORY_PICTURES(get, never):String;
    
    /**
     * Standard directory in which to place documents that have been created by the user.
     */
    public static var DIRECTORY_DOCUMENTS(get, never):String;

    /**
     * Standard directory in which to place movies that are available to the user.
     */
    public static var DIRECTORY_MOVIES(get, never):String;

    /**
     * The traditional location for pictures and videos when mounting the device as a camera.
     */
    public static var DIRECTORY_DCIM(get, never):String;

    /**
     * Standard directory in which to place any audio files that should be in the list of alarms.
     */
    public static var DIRECTORY_ALARMS(get, never):String;

    /**
     * Standard directory in which to place any audio files that should be in the list of ringtones.
     */
    public static var DIRECTORY_RINGTONES(get, never):String;

    /**
     * Standard directory in which to place any audio files that should be in the list of notifications.
     */
    public static var DIRECTORY_NOTIFICATIONS(get, never):String;

    /**
     * Standard directory in which to place podcasts that are available to the user.
     */
    public static var DIRECTORY_PODCASTS(get, never):String;

    /**
     * Standard directory in which to place audiobooks that are available to the user (API 29+).
     */
    public static var DIRECTORY_AUDIOBOOKS(get, never):String;

    /**
     * Standard directory in which to place screenshots that are available to the user (API 29+).
     */
    public static var DIRECTORY_SCREENSHOTS(get, never):String;

    private static function get_DIRECTORY_DOWNLOADS():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_DOWNLOADS", "Ljava/lang/String;");
        return field != null ? field.get() : "Download";
        #else
        return "Download";
        #end
    }

    private static function get_DIRECTORY_MUSIC():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_MUSIC", "Ljava/lang/String;");
        return field != null ? field.get() : "Music";
        #else
        return "Music";
        #end
    }

    private static function get_DIRECTORY_PICTURES():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_PICTURES", "Ljava/lang/String;");
        return field != null ? field.get() : "Pictures";
        #else
        return "Pictures";
        #end
    }

    private static function get_DIRECTORY_DOCUMENTS():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_DOCUMENTS", "Ljava/lang/String;");
        return field != null ? field.get() : "Documents";
        #else
        return "Documents";
        #end
    }

    private static function get_DIRECTORY_MOVIES():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_MOVIES", "Ljava/lang/String;");
        return field != null ? field.get() : "Movies";
        #else
        return "Movies";
        #end
    }

    private static function get_DIRECTORY_DCIM():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_DCIM", "Ljava/lang/String;");
        return field != null ? field.get() : "DCIM";
        #else
        return "DCIM";
        #end
    }

    private static function get_DIRECTORY_ALARMS():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_ALARMS", "Ljava/lang/String;");
        return field != null ? field.get() : "Alarms";
        #else
        return "Alarms";
        #end
    }

    private static function get_DIRECTORY_RINGTONES():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_RINGTONES", "Ljava/lang/String;");
        return field != null ? field.get() : "Ringtones";
        #else
        return "Ringtones";
        #end
    }

    private static function get_DIRECTORY_NOTIFICATIONS():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_NOTIFICATIONS", "Ljava/lang/String;");
        return field != null ? field.get() : "Notifications";
        #else
        return "Notifications";
        #end
    }

    private static function get_DIRECTORY_PODCASTS():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_PODCASTS", "Ljava/lang/String;");
        return field != null ? field.get() : "Podcasts";
        #else
        return "Podcasts";
        #end
    }

    private static function get_DIRECTORY_AUDIOBOOKS():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_AUDIOBOOKS", "Ljava/lang/String;");
        return field != null ? field.get() : "Audiobooks";
        #else
        return "Audiobooks";
        #end
    }

    private static function get_DIRECTORY_SCREENSHOTS():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Environment", "DIRECTORY_SCREENSHOTS", "Ljava/lang/String;");
        return field != null ? field.get() : "Screenshots";
        #else
        return "Screenshots";
        #end
    }

    /**
     * Return the primary shared/external storage directory.
     * * Note: Starting in Android 11 (API level 30), apps cannot freely read/write 
     * in this directory without the MANAGE_EXTERNAL_STORAGE permission due to Scoped Storage.
     * * @return The absolute path of the external storage directory (e.g., "/storage/emulated/0").
     */
    public static function getExternalStorageDirectory():String {
        #if android
        try {
            var getDirFunc = JNICache.getStaticMethod("android/os/Environment", "getExternalStorageDirectory", "()Ljava/io/File;");
            
            if (getDirFunc == null) return "Unknown";
            
            var fileObject:Dynamic = getDirFunc();
            if (fileObject == null) return "Unknown";

            var getPathFunc = JNI.createMemberMethod("java/io/File", "getAbsolutePath", "()Ljava/lang/String;");
            
            var finalPath:String = getPathFunc(fileObject);
            
            return finalPath != null ? finalPath : "Unknown";
            
        } catch(e:Dynamic) {
            return "Error: " + e;
        }
        #else
        return "Unknown";
        #end
    }

    /**
     * Get a top-level shared/external storage directory for placing files of a particular type.
     * @param type The type of storage directory to return (e.g., Environment.DIRECTORY_MUSIC).
     * @return The absolute path of the directory.
     */
    public static function getExternalStoragePublicDirectory(type:String):String {
        #if android
        try {
            var getDirFunc = JNICache.getStaticMethod("android/os/Environment", "getExternalStoragePublicDirectory", "(Ljava/lang/String;)Ljava/io/File;");
            if (getDirFunc == null) return "Unknown";
            
            var fileObject:Dynamic = getDirFunc(type);
            if (fileObject == null) return "Unknown";

            var getPathFunc = JNI.createMemberMethod("java/io/File", "getAbsolutePath", "()Ljava/lang/String;");
            var finalPath:String = getPathFunc(fileObject);
            
            return finalPath != null ? finalPath : "Unknown";
        } catch(e:Dynamic) {
            return "Error: " + e;
        }
        #else
        return "Unknown";
        #end
    }

    /**
     * Return the user data directory.
     * @return The absolute path of the data directory (e.g., "/data").
     */
    public static function getDataDirectory():String {
        #if android
        try {
            var getDirFunc = JNICache.getStaticMethod("android/os/Environment", "getDataDirectory", "()Ljava/io/File;");
            if (getDirFunc == null) return "Unknown";
            var fileObject:Dynamic = getDirFunc();
            if (fileObject == null) return "Unknown";
            var getPathFunc = JNI.createMemberMethod("java/io/File", "getAbsolutePath", "()Ljava/lang/String;");
            var finalPath:String = getPathFunc(fileObject);
            return finalPath != null ? finalPath : "Unknown";
        } catch(e:Dynamic) { return "Error: " + e; }
        #else
        return "Unknown";
        #end
    }

    /**
     * Return the root directory where the Android OS is installed.
     * @return The absolute path of the root directory (e.g., "/system").
     */
    public static function getRootDirectory():String {
        #if android
        try {
            var getDirFunc = JNICache.getStaticMethod("android/os/Environment", "getRootDirectory", "()Ljava/io/File;");
            if (getDirFunc == null) return "Unknown";
            var fileObject:Dynamic = getDirFunc();
            if (fileObject == null) return "Unknown";
            var getPathFunc = JNI.createMemberMethod("java/io/File", "getAbsolutePath", "()Ljava/lang/String;");
            var finalPath:String = getPathFunc(fileObject);
            return finalPath != null ? finalPath : "Unknown";
        } catch(e:Dynamic) { return "Error: " + e; }
        #else
        return "Unknown";
        #end
    }

    /**
     * Return the download/cache content directory.
     * @return The absolute path of the cache directory (e.g., "/cache").
     */
    public static function getDownloadCacheDirectory():String {
        #if android
        try {
            var getDirFunc = JNICache.getStaticMethod("android/os/Environment", "getDownloadCacheDirectory", "()Ljava/io/File;");
            if (getDirFunc == null) return "Unknown";
            var fileObject:Dynamic = getDirFunc();
            if (fileObject == null) return "Unknown";
            var getPathFunc = JNI.createMemberMethod("java/io/File", "getAbsolutePath", "()Ljava/lang/String;");
            var finalPath:String = getPathFunc(fileObject);
            return finalPath != null ? finalPath : "Unknown";
        } catch(e:Dynamic) { return "Error: " + e; }
        #else
        return "Unknown";
        #end
    }

    /**
     * Returns the current state of the primary shared/external storage media.
     */
    public static function getExternalStorageState():String {
        #if android
        var func = JNICache.getStaticMethod("android/os/Environment", "getExternalStorageState", "()Ljava/lang/String;");
        return func != null ? func() : "unknown";
        #else
        return "unknown";
        #end
    }

    /**
     * Returns whether the calling app has All Files Access (MANAGE_EXTERNAL_STORAGE).
     */
    public static function isExternalStorageManager():Bool {
        #if android
        var func = JNICache.getStaticMethod("android/os/Environment", "isExternalStorageManager", "()Z");
        if (func != null) {
            try {
                return func();
            } catch(e:Dynamic) {
                return false;
            }
        }
        return false; 
        #else
        return false;
        #end
    }

    /**
     * Returns whether the primary shared/external storage media is physically removable.
     */
    public static function isExternalStorageRemovable():Bool {
        #if android
        var func = JNICache.getStaticMethod("android/os/Environment", "isExternalStorageRemovable", "()Z");
        return func != null ? func() : false;
        #else
        return false;
        #end
    }

   /**
     * Reads the Android logcat with the specified filter.
     * @param level The minimum log level (e.g., LogLevel.ERROR). Default is DEBUG.
     * @param tag The specific tag to filter (e.g., "haxe", "lime"). Default is "*" (all).
     * @return The complete logcat text.
     */
    public static function dumpSystemLogs(level:LogLevel = DEBUG, tag:String = "*"):String {
        #if android
        try {
            var filter = tag == "*" ? '*:$level' : '$tag:$level *:S';
            
            var process = new sys.io.Process("logcat", ["-d", "-v", "threadtime", filter]);
            
            var output = process.stdout.readAll().toString();
            var errorOutput = process.stderr.readAll().toString();
            process.close();

            if (output.length == 0 && errorOutput.length > 0) {
                return "Error in logcat command: " + errorOutput;
            }

            return output;
        } catch(e:Dynamic) {
            return "Error trying to read logcat: " + e;
        }
        #else
        return "Unknown";
        #end
    }
}