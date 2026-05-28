package androidmanager.os;

#if android
import androidmanager.jni.JNICache;
#end

 /**
 * Information about the current build, extracted from system properties.
 * * @see https://developer.android.com/reference/android/os/Build
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

    /**
     * A string that uniquely identifies this build. 
     * Do not reuse across different builds.
     */
    public static var FINGERPRINT(get, never):String;

    /**
     * The name of the overall product.
     */
    public static var PRODUCT(get, never):String;

    /**
     * The system bootloader version number.
     */
    public static var BOOTLOADER(get, never):String;

    /**
     * Either a changelist number, or a label like "M4-rc20".
     */
    public static var ID(get, never):String;

    /**
     * The name of the host machine where the build was compiled.
     */
    public static var HOST(get, never):String;

    /**
     * The name of the user who compiled the build.
     */
    public static var USER(get, never):String;

    /**
     * Comma-separated tags describing the build, like "unsigned,debug".
     */
    public static var TAGS(get, never):String;

    /**
     * The type of build, like "user" or "eng".
     */
    public static var TYPE(get, never):String;

    /**
     * The time at which the build was produced, given in milliseconds since the UNIX epoch.
     */
    public static var TIME(get, never):Float;

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

    private static function get_FINGERPRINT():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'FINGERPRINT', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_PRODUCT():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'PRODUCT', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_BOOTLOADER():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'BOOTLOADER', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_ID():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'ID', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_HOST():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'HOST', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_USER():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'USER', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_TAGS():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'TAGS', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_TYPE():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'TYPE', 'Ljava/lang/String;');
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_TIME():Float {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField('android/os/Build', 'TIME', 'J');
        return field != null ? field.get() : 0.0;
        #else
        return 0.0;
        #end
    }
}
/**
 * Various version strings and numbers extracted from system properties.
 * * @see https://developer.android.com/reference/android/os/Build.VERSION
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

     /**
     * The current development codename, or the string "REL" if this is a release build.
     */
    public static var CODENAME(get, never):String;

    /**
     * The internal value used by the underlying source control to represent this build.
     */
    public static var INCREMENTAL(get, never):String;

    /**
     * The user-visible security patch level (Requires API 23+).
     */
    public static var SECURITY_PATCH(get, never):String;

    /**
     * The media performance class of the device (Requires API 31+).
     */
    public static var MEDIA_PERFORMANCE_CLASS(get, never):Int;


    private static function get_CODENAME():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Build$VERSION", "CODENAME", "Ljava/lang/String;");
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_INCREMENTAL():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Build$VERSION", "INCREMENTAL", "Ljava/lang/String;");
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_SECURITY_PATCH():String {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Build$VERSION", "SECURITY_PATCH", "Ljava/lang/String;");
        return field != null ? field.get() : "Unknown";
        #else
        return "Unknown";
        #end
    }

    private static function get_MEDIA_PERFORMANCE_CLASS():Int {
        #if android
        final field:Null<Dynamic> = JNICache.getStaticField("android/os/Build$VERSION", "MEDIA_PERFORMANCE_CLASS", "I");
        return field != null ? field.get() : 0;
        #else
        return 0;
        #end
    }

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