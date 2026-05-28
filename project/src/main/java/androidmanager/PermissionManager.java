package androidmanager.java;

import android.content.pm.PackageManager;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import org.haxe.extension.Extension;

public class PermissionManager {

    /**
     * Checks if a specific Android permission has been granted.
     * @param permission The permission string (e.g., "android.permission.READ_EXTERNAL_STORAGE")
     * @return true if granted, false otherwise.
     */
    public static boolean hasPermission(String permission) {
        if (Extension.mainActivity == null) {
            return false;
        }
        
        int result = ContextCompat.checkSelfPermission(Extension.mainActivity, permission);
        return result == PackageManager.PERMISSION_GRANTED;
    }

    /**
     * Requests a specific Android permission from the user.
     * @param permission The permission string to request.
     */
    public static void requestPermission(String permission) {
        if (Extension.mainActivity == null) {
            return;
        }

        String[] permissionsArray = new String[]{ permission };
        ActivityCompat.requestPermissions(Extension.mainActivity, permissionsArray, 1024);
    }
}
