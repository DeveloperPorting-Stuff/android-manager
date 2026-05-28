package androidmanager.content;

#if android
import lime.system.JNI;
import androidmanager.jni.JNICache;
#end

/**
 * Interface to global information about an application environment.
 * @see https://developer.android.com/reference/android/content/Context
 */
class Context {

   /**
     * Returns the absolute path to the directory on the primary shared/external 
     * storage device where the application can place persistent files it owns.
     * (e.g., "/storage/emulated/0/Android/data/com.your.package/files")
     * * @param type The type of files directory to return (e.g., Environment.DIRECTORY_MUSIC). Pass null for the root files directory.
     * @return The absolute path of the directory.
     */
    public static function getExternalFilesDir(type:String = null):String {
        #if android
        try {
            return "in dev...";
        } catch(e:Dynamic) {
            return "Error: " + e;
        }
        #else
        return "Unknown";
        #end
    }
}