package androidmanager.battery;

#if android
import lime.system.JNI;
#end

enum abstract BatteryStatus(Int) to Int {
    var Unknown = 1;
    var Charging = 2;
    var Discharging = 3;
    var NotCharging = 4;
    var Full = 5;
}

enum abstract BatteryHealth(Int) to Int {
    var Unknown = 1;
    var Good = 2;
    var Overheat = 3;
    var Dead = 4;
    var OverVoltage = 5;
    var UnspecifiedFailure = 6;
    var Cold = 7;
}

enum abstract BatteryPlugged(Int) to Int {
    var Unplugged = 0;
    var AC = 1;
    var USB = 2;
    var Wireless = 4;
}

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

class Battery {

    public static var onBatteryChanged:(info:BatteryInfo)->Void = null;

    #if android
    private static var _initialized:Bool = false;

    private static var _init:Dynamic = null;
    private static var _setCallback:Dynamic = null;
    private static var _getLevel:Dynamic = null;
    private static var _getStatus:Dynamic = null;
    private static var _getHealth:Dynamic = null;
    private static var _getPlugged:Dynamic = null;
    private static var _getTemperature:Dynamic = null;
    private static var _getVoltage:Dynamic = null;
    private static var _getTechnology:Dynamic = null;
    private static var _isCharging:Dynamic = null;
    private static var _isLow:Dynamic = null;
    private static var _isPowerSaveMode:Dynamic = null;
    private static var _getChargeTimeRemaining:Dynamic = null;
    private static var _startListening:Dynamic = null;
    private static var _stopListening:Dynamic = null;
    private static var _isListening:Dynamic = null;

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

    public static function init():Void {
        #if android
        if (_initialized)
            return;

        if (_init == null)
            _init = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "init", "()V"
            );

        if (_setCallback == null)
            _setCallback = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt",
                "setCallback",
                "(Lorg/haxe/lime/HaxeObject;)V"
            );

        _init();
        _setCallback(_callbackObj);
        _initialized = true;
        #end
    }

    public static function getLevel():Int {
        #if android
        if (_getLevel == null)
            _getLevel = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "getLevel", "()I"
            );

        return _getLevel();
        #else
        return -1;
        #end
    }

    public static function getStatus():BatteryStatus {
        #if android
        if (_getStatus == null)
            _getStatus = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "getStatus", "()I"
            );

        return cast _getStatus();
        #else
        return Unknown;
        #end
    }

    public static function getHealth():BatteryHealth {
        #if android
        if (_getHealth == null)
            _getHealth = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "getHealth", "()I"
            );

        return cast _getHealth();
        #else
        return Unknown;
        #end
    }

    public static function getPlugged():BatteryPlugged {
        #if android
        if (_getPlugged == null)
            _getPlugged = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "getPlugged", "()I"
            );

        return cast _getPlugged();
        #else
        return Unplugged;
        #end
    }

    public static function getTemperature():Float {
        #if android
        if (_getTemperature == null)
            _getTemperature = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "getTemperature", "()F"
            );

        return _getTemperature();
        #else
        return -1;
        #end
    }

    public static function getVoltage():Int {
        #if android
        if (_getVoltage == null)
            _getVoltage = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "getVoltage", "()I"
            );

        return _getVoltage();
        #else
        return -1;
        #end
    }

    public static function getTechnology():Null<String> {
        #if android
        if (_getTechnology == null)
            _getTechnology = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt",
                "getTechnology",
                "()Ljava/lang/String;"
            );

        return _getTechnology();
        #else
        return null;
        #end
    }

    public static function isCharging():Bool {
        #if android
        if (_isCharging == null)
            _isCharging = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "isCharging", "()Z"
            );

        return _isCharging();
        #else
        return false;
        #end
    }

    public static function isLow():Bool {
        #if android
        if (_isLow == null)
            _isLow = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "isLow", "()Z"
            );

        return _isLow();
        #else
        return false;
        #end
    }

    public static function isPowerSaveMode():Bool {
        #if android
        if (_isPowerSaveMode == null)
            _isPowerSaveMode = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "isPowerSaveMode", "()Z"
            );

        return _isPowerSaveMode();
        #else
        return false;
        #end
    }

    public static function getChargeTimeRemaining():Int {
        #if android
        if (_getChargeTimeRemaining == null)
            _getChargeTimeRemaining = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "getChargeTimeRemaining", "()J"
            );

        return _getChargeTimeRemaining();
        #else
        return -1;
        #end
    }

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

    public static function startListening():Void {
        #if android
        if (_startListening == null)
            _startListening = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "startListening", "()V"
            );

        _startListening();
        #end
    }

    public static function stopListening():Void {
        #if android
        if (_stopListening == null)
            _stopListening = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "stopListening", "()V"
            );

        _stopListening();
        #end
    }

    public static function isListening():Bool {
        #if android
        if (_isListening == null)
            _isListening = JNI.createStaticMethod(
                "androidmanager/BatteryManagerExt", "isListening", "()Z"
            );

        return _isListening();
        #else
        return false;
        #end
    }
}
