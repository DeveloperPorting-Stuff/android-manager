package androidmanager.os;

#if android
import androidmanager.jni.JNICache;
#end
class Build {
    
    /**
     * Retrieves the device hardware model.
     * @return The model string, or "Unknown" if not on Android.
     */
    public static function model():String {
        #if android
        var field = JNICache.getStaticField("android/os/Build", "MODEL", "Ljava/lang/String;");
        if (field != null) return field.get(); 
        #end
        
        return "Unknown";
    }

    /**
     * Retrieves the device manufacturer.
     * @return The manufacturer string, or "Unknown" if not on Android.
     */
    public static function manufacturer():String {
        #if android
        var field = JNICache.getStaticField('android/os/Build', 'MANUFACTURER', 'Ljava/lang/String;');
        if (field != null) return field.get();
        #end
        
        return "Unknown";
    }

     /**
     * Retrieves the name of the device's industrial design.
     * @return The design string, or "Unknown" if not on Android.
     */
    public static function device():String {
        #if android
        var field = JNICache.getStaticField('android/os/Build', 'DEVICE', 'Ljava/lang/String;');
        if (field != null) return field.get();
        #end

        return "Unknown";
    }
}