package androidmanager.battery;

#if android
import androidmanager.jni.JNICache;
#end

/**
 * Provides access to the device's battery information and charging status.
 * @see https://developer.android.com/reference/android/os/BatteryManager
 */
enum abstract BatteryStatus(Int) to Int {
    var Unknown = 1;
    var Charging = 2;
    var Discharging = 3;
    var NotCharging = 4;
    var Full = 5;
}

/**
 * Represents the health state of the battery.
 */
enum abstract BatteryHealth(Int) to Int {
    var Unknown = 1;
    var Good = 2;
    var Overheat = 3;
    var Dead = 4;
    var OverVoltage = 5;
    var UnspecifiedFailure = 6;
    var Cold = 7;
}

/**
 * Represents the type of power source the device is currently plugged into.
 */
enum abstract BatteryPlugged(Int) to Int {
    var Unplugged = 0;
    var AC = 1;
    var USB = 2;
    var Wireless = 4;
}

/**
 * A snapshot containing the complete state of the battery at a specific moment.
 */
typedef BatteryInfo = {
    var level:Int;
    var status:BatteryStatus;
    var health:BatteryHealth;
    var plugged:BatteryPlugged;
    var temperature:Float;
    var charging:Bool;
    var low:Bool;
    var powerSave:Bool;
}

/**
 * Provides access to the device's battery information and charging status.
 */
class Battery {

    /**
     * Callback triggered whenever the battery state changes (e.g., level drops or charger is plugged).
     * Must call `startListening()` to activate.
     */
    public static var onBatteryChanged:(info:BatteryInfo)->Void = null;

    #if android
    private static var _initialized:Bool = false;

    // The HaxeObject passed to Java to receive the real-time callback events
    private static var _callbackObj = {
        onBatteryChanged: function(
            level:Int, status:Int, health:Int, plugged:Int,
            temperature:Float, charging:Bool, low:Bool, powerSave:Bool
        ):Void {
            if (Battery.onBatteryChanged == null)
                return;

            Battery.onBatteryChanged({
                level: level,
                status: cast status,
                health: cast health,
                plugged: cast plugged,
                temperature: temperature,
                charging: charging,
                low: low,
                powerSave: powerSave
            });
        }
    };
    #end

    /**
     * Initializes the Battery Manager JNI bridge.
     * This is required before starting the listener, but optional for single method calls.
     */
    public static function init():Void {
        #if android
        if (_initialized)
            return;

        var initFunc = JNICache.getStaticMethod("java/androidmanager/Battery", "init", "()V");
        if (initFunc != null) initFunc();

        var setCallbackFunc = JNICache.getStaticMethod("java/androidmanager/Battery", "setCallback", "(Lorg/haxe/lime/HaxeObject;)V");
        if (setCallbackFunc != null) setCallbackFunc(_callbackObj);

        _initialized = true;
        #end
    }

    /**
     * Returns the current battery level as an integer.
     * @return Battery percentage from 0 to 100, or -1 if unavailable.
     */
    public static function getLevel():Int {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "getLevel", "()I");
        return func != null ? func() : -1;
        #else
        return -1;
        #end
    }

    /**
     * Returns the current charging status of the device.
     * @return A `BatteryStatus` enum value.
     */
    public static function getStatus():BatteryStatus {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "getStatus", "()I");
        return func != null ? cast func() : Unknown;
        #else
        return Unknown;
        #end
    }

    /**
     * Returns the current health condition of the battery.
     * @return A `BatteryHealth` enum value.
     */
    public static function getHealth():BatteryHealth {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "getHealth", "()I");
        return func != null ? cast func() : Unknown;
        #else
        return Unknown;
        #end
    }

    /**
     * Returns the type of power source the device is currently plugged into.
     * @return A `BatteryPlugged` enum value.
     */
    public static function getPlugged():BatteryPlugged {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "getPlugged", "()I");
        return func != null ? cast func() : Unplugged;
        #else
        return Unplugged;
        #end
    }

    /**
     * Returns the current battery temperature.
     * @return The temperature in degrees Celsius (°C).
     */
    public static function getTemperature():Float {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "getTemperature", "()F");
        return func != null ? func() : -1;
        #else
        return -1;
        #end
    }

    /**
     * Returns the current battery voltage.
     * @return The voltage in millivolts (mV).
     */
    public static function getVoltage():Int {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "getVoltage", "()I");
        return func != null ? func() : -1;
        #else
        return -1;
        #end
    }

    /**
     * Returns the technology of the current battery (e.g., "Li-ion").
     * @return The battery technology as a string, or null if unknown.
     */
    public static function getTechnology():Null<String> {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "getTechnology", "()Ljava/lang/String;");
        return func != null ? cast func() : null;
        #else
        return null;
        #end
    }

    /**
     * Checks whether the device is currently connected to a power source and charging.
     * @return True if charging or full, false otherwise.
     */
    public static function isCharging():Bool {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "isCharging", "()Z");
        return func != null ? func() : false;
        #else
        return false;
        #end
    }

    /**
     * Checks whether the battery level is critically low (typically 15% or less) 
     * or if the device is in idle mode.
     * @return True if the battery is low, false otherwise.
     */
    public static function isLow():Bool {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "isLow", "()Z");
        return func != null ? func() : false;
        #else
        return false;
        #end
    }

    /**
     * Checks whether the device is currently in power save (battery saver) mode.
     * @return True if power save mode is enabled, false otherwise.
     */
    public static function isPowerSaveMode():Bool {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "isPowerSaveMode", "()Z");
        return func != null ? func() : false;
        #else
        return false;
        #end
    }

    /**
     * Returns the estimated time remaining until the battery is fully charged.
     * Requires API level 28+ (Android 9).
     * @return Time remaining in milliseconds, or -1 if the device is not charging or unable to compute.
     */
    public static function getChargeTimeRemaining():Int {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "getChargeTimeRemaining", "()J");
        return func != null ? cast func() : -1;
        #else
        return -1;
        #end
    }

    /**
     * Collects and returns a snapshot containing all primary battery information at the current moment.
     * @return A `BatteryInfo` object with the current state.
     */
    public static function getSnapshot():BatteryInfo {
        return {
            level: getLevel(),
            status: getStatus(),
            health: getHealth(),
            plugged: getPlugged(),
            temperature: getTemperature(),
            charging: isCharging(),
            low: isLow(),
            powerSave: isPowerSaveMode()
        };
    }

    /**
     * Registers a broadcast receiver to listen for real-time battery changes.
     * Triggers the `onBatteryChanged` callback.
     */
    public static function startListening():Void {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "startListening", "()V");
        if (func != null) func();
        #end
    }

    /**
     * Unregisters the broadcast receiver, stopping real-time battery updates.
     */
    public static function stopListening():Void {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "stopListening", "()V");
        if (func != null) func();
        #end
    }

    /**
     * Checks whether the application is currently listening for real-time battery events.
     * @return True if the listener is active, false otherwise.
     */
    public static function isListening():Bool {
        #if android
        var func = JNICache.getStaticMethod("java/androidmanager/Battery", "isListening", "()Z");
        return func != null ? func() : false;
        #else
        return false;
        #end
    }
}