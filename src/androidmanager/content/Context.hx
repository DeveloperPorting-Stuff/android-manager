package androidmanager.content;

#if android
import lime.system.JNI;
#end

/**
 * Interface to global information about an application environment.
 * @see https://developer.android.com/reference/android/content/Context
 */
class Context {

    private static var _getExternalFilesDir:Dynamic = null;

    /**
     * Returns the absolute path to the directory on the primary shared/external 
     * storage device where the application can place persistent files it owns.
     * (e.g., "/storage/emulated/0/Android/data/com.your.package/files")
     * * @param type The type of files directory to return (e.g., Environment.DIRECTORY_MUSIC). Pass null for the root files directory.
     * @return The absolute path of the directory.
     */
    public static function getExternalFilesDir(type:String = null):String {
        #if android
        if (_getExternalFilesDir == null) {
            try {
                _getExternalFilesDir = JNI.createStaticMethod("androidmanager/java/ContextManager", "getExternalFilesDir", "(Ljava/lang/String;)Ljava/lang/String;");
            } catch(e:Dynamic) {
                return "JNI Error " + e;
            }
        }
        
        if (_getExternalFilesDir != null) {
            try {
                var path:String = _getExternalFilesDir(type);
                return (path != null) ? path : "Unknown";
            } catch (e:Dynamic) {
                return "Error while executing JNI: " + e;
            }
        }
        
        return "Unknown";
        #else
        return "Unknown";
        #end
    }

}