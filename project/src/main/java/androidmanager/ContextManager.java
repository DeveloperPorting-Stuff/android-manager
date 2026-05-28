package androidmanager;

import android.os.Environment;
import org.haxe.extension.Extension;
import java.io.File;

public class ContextManager {

    public static String getExternalFilesDir(String type) {
        if (Extension.mainActivity == null)
            return null;

        File dir = Extension.mainActivity.getExternalFilesDir(
            (type == null || type.isEmpty()) ? null : type
        );

        if (dir != null && (dir.exists() || dir.mkdirs()))
            return dir.getAbsolutePath();

        return null;
    }

    public static String getInternalFilesDir() {
        if (Extension.mainActivity == null)
            return null;

        File dir = Extension.mainActivity.getFilesDir();

        if (dir != null && (dir.exists() || dir.mkdirs()))
            return dir.getAbsolutePath();

        return null;
    }

    public static boolean isExternalStorageAvailable() {
        return Environment.MEDIA_MOUNTED.equals(Environment.getExternalStorageState());
    }
}