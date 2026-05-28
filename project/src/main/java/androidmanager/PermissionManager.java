package androidmanager;

import android.content.pm.PackageManager;
import android.os.Build;
import org.haxe.extension.Extension;

public class PermissionManager {

    private static final int REQUEST_CODE = 1024;

    public static boolean hasPermission(String permission) {
        if (Extension.mainActivity == null || permission == null)
            return false;

        if (Build.VERSION.SDK_INT >= 23) {
            return Extension.mainContext.checkSelfPermission(permission) == PackageManager.PERMISSION_GRANTED;
        }
        
        return true;
    }

    public static void requestPermission(final String permission) {
        if (Extension.mainActivity == null || permission == null)
            return;

        if (Build.VERSION.SDK_INT >= 23) {
            Extension.mainActivity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Extension.mainActivity.requestPermissions(
                        new String[]{ permission },
                        REQUEST_CODE
                    );
                }
            });
        }
    }

    public static void requestPermissions(final String[] permissions) {
        if (Extension.mainActivity == null || permissions == null || permissions.length == 0)
            return;

        if (Build.VERSION.SDK_INT >= 23) {
            Extension.mainActivity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Extension.mainActivity.requestPermissions(
                        permissions,
                        REQUEST_CODE
                    );
                }
            });
        }
    }

    public static boolean hasPermissions(String[] permissions) {
        if (Extension.mainActivity == null || permissions == null)
            return false;

        if (Build.VERSION.SDK_INT >= 23) {
            for (String permission : permissions) {
                if (permission == null)
                    continue;
                
                if (Extension.mainContext.checkSelfPermission(permission) != PackageManager.PERMISSION_GRANTED)
                    return false;
            }
        }

        return true;
    }
}