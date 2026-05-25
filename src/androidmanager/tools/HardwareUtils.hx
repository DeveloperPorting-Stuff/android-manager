package androidmanager.tools;

class HardwareUtils {
    
    private static var _getDeviceModel:Dynamic;
    private static var _getDeviceManufacturer:Dynamic;

    /**
     * Returns the device's hardware model.
     */
    public static function getDeviceModel():String {
        #if android
        if (_getDeviceModel == null) {
            _getDeviceModel = JNIUtils.createStaticMethod("androidmanager/java/HardwareExtension", "getDeviceModel", "()Ljava/lang/String;");
        }
        
        if (_getDeviceModel != null) {
            return _getDeviceModel();
        }
        #end
        
        return "Unknown";
    }

    /**
     * Returns the device's hardware manufacturer.
     */
    public static function getDeviceManufacturer():String {
        #if android
        if (_getDeviceManufacturer == null) {
            _getDeviceManufacturer = JNIUtils.createStaticMethod("androidmanager/java/HardwareExtension", "getDeviceManufacturer", "()Ljava/lang/String;");
        }
        
        if (_getDeviceManufacturer != null) {
            return _getDeviceManufacturer();
        }
        #end
        
        return "Unknown";
    }
}