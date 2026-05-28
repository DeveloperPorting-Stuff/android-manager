package java.androidmanager;

import android.os.Environment;
import org.haxe.extension.Extension;
import java.io.File;

public class ContextManager {

    public static class Storage {

        public static String getDataDir() {
            if (Extension.mainActivity == null) return "";
            return Extension.mainActivity.getDataDir().getAbsolutePath();
        }

        public static String getCodeCacheDir() {
            if (Extension.mainActivity == null) return "";
            return Extension.mainActivity.getCodeCacheDir().getAbsolutePath();
        }

        public static String getNoBackupFilesDir() {
            if (Extension.mainActivity == null) return "";
            return Extension.mainActivity.getNoBackupFilesDir().getAbsolutePath();
        }

        public static String getDatabasePath(String name) {
            if (Extension.mainActivity == null) return "";
            return Extension.mainActivity.getDatabasePath(name).getAbsolutePath();
        }

        public static String getFileStreamPath(String name) {
            if (Extension.mainActivity == null) return "";
            return Extension.mainActivity.getFileStreamPath(name).getAbsolutePath();
        }

        public static String getExternalCacheDirs() {
            if (Extension.mainActivity == null) return "";
            File[] dirs = Extension.mainActivity.getExternalCacheDirs();
            return formatFileArray(dirs);
        }

        public static String getExternalFilesDirs(String type) {
            if (Extension.mainActivity == null) return "";
            File[] dirs = Extension.mainActivity.getExternalFilesDirs((type == null || type.isEmpty()) ? null : type);
            return formatFileArray(dirs);
        }

        public static String getInternalFilesDir() {
            if (Extension.mainContext == null) return null;
            File dir = Extension.mainContext.getFilesDir();
            return (dir != null && (dir.exists() || dir.mkdirs())) ? dir.getAbsolutePath() : null;
        }

        public static String getCacheDir() {
            if (Extension.mainContext == null) return null;
            File dir = Extension.mainContext.getCacheDir();
            return (dir != null && (dir.exists() || dir.mkdirs())) ? dir.getAbsolutePath() : null;
        }

        public static String getObbDir() {
            if (Extension.mainContext == null) return null;
            File dir = Extension.mainContext.getObbDir();
            return (dir != null && (dir.exists() || dir.mkdirs())) ? dir.getAbsolutePath() : null;
        }

        public static boolean isExternalStorageAvailable() {
            String state = Environment.getExternalStorageState();
            return Environment.MEDIA_MOUNTED.equals(state);
        }

        private static String formatFileArray(File[] dirs) {
            StringBuilder sb = new StringBuilder();
            for (File f : dirs) {
                if (f != null) sb.append(f.getAbsolutePath()).append(";");
            }
            return sb.toString();
        }
    }
    public static class App {

        public static String getPackageName() {
            if (Extension.mainContext == null) return "Unknown";
            return Extension.mainContext.getPackageName();
        }
    }
}