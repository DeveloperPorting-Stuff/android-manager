package androidmanager.java;

import org.haxe.extension.Extension;
import java.io.File;

public class ContextManager {

    public static String getExternalFilesDir(String type) {
        if (Extension.mainContext == null) {
            return "Error: Context not ready.";
        }
        
        File dir = Extension.mainContext.getExternalFilesDir(type);
        
        if (dir != null) {
            return dir.getAbsolutePath();
        }
        
        return "Unknown";
    }
}