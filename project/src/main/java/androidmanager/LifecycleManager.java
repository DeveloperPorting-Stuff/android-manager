package java.androidmanager;

import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

public class LifecycleManager extends Extension {
    private static HaxeObject exitCallback = null;

    public static void setExitCallback(HaxeObject callback) {
        exitCallback = callback;
    }

    @Override
    public void onPause() {
        super.onPause();
        if (exitCallback != null) {
            try {
                exitCallback.call("onTrigger", new Object[]{});
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}