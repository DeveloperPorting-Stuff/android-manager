package androidmanager.java;

import android.os.Build;

public class HardwareExtension {
    
    public static String getDeviceModel() {
        return Build.MODEL;
    }

    public static String getDeviceManufacturer() {
        return Build.MANUFACTURER;
    }
}
