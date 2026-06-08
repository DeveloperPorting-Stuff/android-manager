package androidmanager.content;

import androidmanager.jni.JNICache;
using StringTools;

/**
 * Provides an interface for native Android UI components and system navigation.
 * Allows triggering native alerts and opening Android system settings.
 */
class Interface {

    /**
     * Displays a native Android alert dialog.
     * * @param title The dialog title.
     * @param msg The body text of the dialog.
     * @param btn The label text for the positive button (defaults to "OK").
     * @param onClose Optional callback function triggered when the button is pressed.
     */
    public static function showAlert(title:String, msg:String, btn:String = "OK", ?onClose:Void->Void):Void {
        var jni:Dynamic = JNICache.getStaticMethod("java/androidmanager/Interface", "alert", 
            "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/haxe/lime/HaxeObject;)V");
        
        if (jni != null) 
            jni(title, msg, btn, new NativeCallback(onClose));
    }

    /**
     * Navigates the user to a specific Android system settings menu.
     * * @param action The name of the settings intent action. 
     * If it does not start with 'android.settings.', it will be prefixed automatically.
     * @param code The unique request code associated with the intent.
     */
    public static function requestSetting(action:String, code:Int = 1):Void {
        var jni:Dynamic = JNICache.getStaticMethod("java/androidmanager/Interface", "navigate", "(Ljava/lang/String;I)V");
        
        if (jni != null) {
            var fullAction = action.startsWith("android.settings.") ? action : "android.settings." + action;
            jni(fullAction, code);
        }
    }
}

/**
 * Internal helper to bridge Haxe functions to Android native callbacks.
 */
private class NativeCallback {
    var callback:Void->Void;

    public function new(f:Void->Void) {
        this.callback = f;
    }
    
    /**
     * Triggered by the Android native side when a dialog event occurs.
     */
    @:keep 
    public function onTrigger():Void {
        if (callback != null) 
            callback();
    }
}
