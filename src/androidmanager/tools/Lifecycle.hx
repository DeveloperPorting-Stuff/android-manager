package androidmanager.tools;

#if android
import androidmanager.jni.JNICache;
#end

/**
 * Manages native Android lifecycle events.
 */
class Lifecycle {

    private static var _exitCallbacks:Array<Void->Void> = [];
    private static var _initialized:Bool = false;

    /**
     * Adds functions to be executed after the application is minimized.
     * @param callback Parameter in Void format.
     */
    public static function addOnExit(callback:Void->Void):Void {
        if (callback == null) return;
        
        initIfNeeded();
        
        if (_exitCallbacks.indexOf(callback) == -1) {
            _exitCallbacks.push(callback);
        }
    }

    /**
     * Remove a function from the list.
     * @param callback Parameter in Void format.
     */
    public static function removeOnExit(callback:Void->Void):Void {
        _exitCallbacks.remove(callback);
    }

    private static function initIfNeeded():Void {
        if (_initialized) return;
        _initialized = true;

        #if android
        var func = JNICache.getStaticMethod(
            "java/androidmanager/LifecycleManager",
            "setExitCallback",
            "(Lorg/haxe/lime/HaxeObject;)V"
        );

        if (func != null) {
            func(new LifecycleCallback());
        }
        #end
    }

    public static function __dispatchExit():Void {
        for (cb in _exitCallbacks) {
            if (cb != null) {
                try {
                    cb();
                } catch (e:Dynamic) {
                    trace("Lifecycle exit callback failed: " + e);
                }
            }
        }
    }
}

/**
 * Internal helper for the JNI bridge between Java and Haxe.
 */
@:unreflective
private class LifecycleCallback {
    public function new() {}

    @:keep
    public function onTrigger():Void {
        Lifecycle.__dispatchExit();
    }
}