package androidmanager.os;

#if android
import androidmanager.jni.JNICache;
#end

/**
 * Information about the current build, extracted from system properties.
 */
class Build {
    
    /**
     * The end-user-visible name for the end product.
     */
    public static var MODEL(get, never):String;

    /**
     * The manufacturer of the product/hardware.
     */
    public static var MANUFACTURER(get, never):String;

    /**
     * The name of the industrial design.
     */
    public static var DEVICE(get, never):String;

    /**
     * The name of the underlying board, like "goldfish".
     */
    public static var BOARD(get, never):String;

    /**
     * The consumer-visible brand with which the product/hardware will be associated, if any.
     */
    public static var BRAND(get, never):String;

    /**
     * The name of the hardware (from the kernel command line or /proc).
     */
    public static var HARDWARE(get, never):String;

    /**
     * A build ID string meant for displaying to the user.
     */
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

/**
 * Various version strings and numbers extracted from system properties.
 */
class VERSION {
    
    /**
     * The base OS build the product is based on.
     */
    public static var BASE_OS(get, never):String;

    /**
     * The user-visible version string (e.g., "15", "14", "13").
     */
    public static var RELEASE(get, never):String;

    /**
     * The SDK version of the software currently running on this hardware device.
     */
    public static var SDK_INT(get, never):Int;

    private static function get_RELEASE():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Build$VERSION", "RELEASE", "Ljava/lang/String;");
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_SDK_INT():Int {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Build$VERSION", "SDK_INT", "I");
        return field != null ? field.get() : 0;
        #else
        return 0;
        #end
    }

    private static function get_BASE_OS():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Build$VERSION", "BASE_OS", "Ljava/lang/String;");
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }
}