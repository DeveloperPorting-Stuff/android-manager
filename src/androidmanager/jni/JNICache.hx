package androidmanager.jni;

#if android
import lime.system.JNI;
#end

class JNICache { 
    // thanks for the idea saw

    #if android
    private static var cache:Map<String, Dynamic> = new Map();
    #end

    public static function getStaticMethod(className:String, methodName:String, signature:String):Dynamic {
        #if android
        var key:String = className + "::" + methodName;

        if (!cache.exists(key)) {
            try {
                var method = JNI.createStaticMethod(className, methodName, signature);
                cache.set(key, method);
            } catch (e:Dynamic) {
                trace("JNICache: Could not find " + key + " in Java!");
                return null;
            }
        }

        return cache.get(key);
        #else
        return null; 
        #end
    }

    public static function getStaticField(className:String, fieldName:String, signature:String):Dynamic {
        #if android
        var key:String = className + "::FIELD::" + fieldName;

        if (!cache.exists(key)) {
            try {
                var field = JNI.createStaticField(className, fieldName, signature);
                cache.set(key, field);
            } catch (e:Dynamic) {
                trace("JNICache: Could not find variable " + fieldName + " in Java!");
                return null;
            }
        }

        return cache.get(key);
        #else
        return null; 
        #end
    }
}