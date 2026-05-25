package androidmanager.tools;

#if android
import lime.system.JNI;
#end

class HardwareUtils {
    
    private static var _getDeviceModel:Dynamic = null;
    private static var _getDeviceManufacturer:Dynamic = null;

    /**
     * Retrieves the device hardware model.
     * @return The model string, or "Unknown" if not on Android.
     */
    public static function getDeviceModel():String {
        #if android
        if (_getDeviceModel == null) {
            _getDeviceModel = JNI.createStaticMethod("androidmanager/java/HardwareExtension", "getDeviceModel", "()Ljava/lang/String;");
        }
        
        if (_getDeviceModel != null) {
            return _getDeviceModel();
        }
        #end
        
        return "Unknown";
    }

    /**
     * Retrieves the device manufacturer.
     * @return The manufacturer string, or "Unknown" if not on Android.
     */
    public static function getDeviceManufacturer():String {
        #if android
        if (_getDeviceManufacturer == null) {
            _getDeviceManufacturer = JNI.createStaticMethod("androidmanager/java/HardwareExtension", "getDeviceManufacturer", "()Ljava/lang/String;");
        }
        
        if (_getDeviceManufacturer != null) {
            return _getDeviceManufacturer();
        }
        #end
        
        return "Unknown";
    }
}