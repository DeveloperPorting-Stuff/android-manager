package java.androidmanager;

import android.os.Environment;
import org.haxe.extension.Extension;
import java.io.File;

public class ContextManager {

    public static class Storage {
        
        public static String getExternalFilesDir(String type) {
            if (Extension.mainContext == null) return null;
            File dir = Extension.mainContext.getExternalFilesDir((type == null || type.isEmpty()) ? null : type);
            if (dir != null && (dir.exists() || dir.mkdirs())) return dir.getAbsolutePath();
            return null;
        }

        public static String getInternalFilesDir() {
            if (Extension.mainContext == null) return null;
            File dir = Extension.mainContext.getFilesDir();
            if (dir != null && (dir.exists() || dir.mkdirs())) return dir.getAbsolutePath();
            return null;
        }

        public static String getCacheDir() {
            if (Extension.mainContext == null) return null;
            File dir = Extension.mainContext.getCacheDir();
            if (dir != null && (dir.exists() || dir.mkdirs())) return dir.getAbsolutePath();
            return null;
        }

        public static String getObbDir() {
            if (Extension.mainContext == null) return null;
            File dir = Extension.mainContext.getObbDir();
            if (dir != null && (dir.exists() || dir.mkdirs())) return dir.getAbsolutePath();
            return null;
        }

        public static boolean isExternalStorageAvailable() {
            String state = Environment.getExternalStorageState();
            return Environment.MEDIA_MOUNTED.equals(state);
        }
    }
    public static class App {
        
        public static String getPackageName() {
            if (Extension.mainContext == null) return "Unknown";
            return Extension.mainContext.getPackageName();
        }
    }
}