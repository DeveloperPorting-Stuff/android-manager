package androidmanager;

import android.content.pm.PackageManager;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import org.haxe.extension.Extension;

public class PermissionManager {

    private static final int REQUEST_CODE = 1024;

    public static boolean hasPermission(String permission) {
        if (Extension.mainActivity == null || permission == null)
            return false;

        return ContextCompat.checkSelfPermission(Extension.mainActivity, permission)
            == PackageManager.PERMISSION_GRANTED;
    }

    public static void requestPermission(final String permission) {
        if (Extension.mainActivity == null || permission == null)
            return;

        Extension.mainActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                ActivityCompat.requestPermissions(
                    Extension.mainActivity,
                    new String[]{ permission },
                    REQUEST_CODE
                );
            }
        });
    }
}