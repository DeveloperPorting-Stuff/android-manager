package androidmanager.tools;

#if android
import cpp.vm.Jni;
#end

class JNIUtils {
    
    /**
     * Creates a link using a static Java method.
     * @param className The Java class path (e.g., "androidmanager/java/HardwareExtension")
     * @param methodName The name of the Java method (e.g., "getDeviceModel")
     * @param signature The JNI signature of the method (e.g., "()Ljava/lang/String;")
     */
    public static function createStaticMethod(className:String, methodName:String, signature:String):Dynamic {
        #if android
        try {
            return Jni.createStaticMethod(className, methodName, signature);
        } catch (e:Dynamic) {
            trace('Error creating JNI method ($className.$methodName): $e');
            return null;
        }
        #els
        return function(...args:Array<Dynamic>):Dynamic { 
            trace("JNI is not supported on this platform."); 
            return null; 
        };
        #end
    }
}
