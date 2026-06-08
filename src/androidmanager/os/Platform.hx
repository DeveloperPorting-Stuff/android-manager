package androidmanager.os;

import androidmanager.jni.JNICache;

class Platform {
	/**
	 * Retrieves the current device wallpaper as a Base64 encoded PNG string.
	 *
	 * @return The Base64 string of the wallpaper, or null if it fails.
	 */
	public static inline function getWallpaperBase64():Null<String> {
		final getWallpaperBase64JNI:Null<Dynamic> = JNICache.getStaticMethod('java/androidmanager/Platform', 'getWallpaperBase64', '()Ljava/lang/String;');

		if (getWallpaperBase64JNI != null)
			return getWallpaperBase64JNI();

		return null;
	}

	/**
     * Requests a specific Android system setting screen using JNI.
     *
     * @param targetSetting The name of the setting. If it does not start with 'android.settings.', 
     * it will be prefixed automatically.
     * @param id The request code to be passed to the JNI method.
     */
    public static inline function requestSetting(targetSetting:String, id:Int = 1):Void {
        final jniRouter:Null<Dynamic> = JNICache.getStaticMethod('java/androidmanager/Platform', 'openSettingsMenu', '(Ljava/lang/String;I)V');

        if (jniRouter != null) {
            var parsedAction:String = targetSetting;

            if (parsedAction.indexOf('android.settings.') != 0)
                parsedAction = 'android.settings.' + targetSetting;

            jniRouter(parsedAction, id);
        }
    }
}
