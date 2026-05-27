package androidmanager.os;

#if android
import androidmanager.jni.JNICache;
#end
class Build {
    
    public static var MODEL(get, never):String;
    public static var MANUFACTURER(get, never):String;
    public static var DEVICE(get, never):String;
    public static var BOARD(get, never):String;
    public static var BRAND(get, never):String;
    public static var HARDWARE(get, never):String;
    public static var DISPLAY(get, never):String;

    private static function get_MODEL():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'MODEL', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_MANUFACTURER():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'MANUFACTURER', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_DEVICE():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'DEVICE', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_BOARD():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'BOARD', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_BRAND():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'BRAND', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_HARDWARE():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'HARDWARE', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_DISPLAY():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'DISPLAY', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }
}