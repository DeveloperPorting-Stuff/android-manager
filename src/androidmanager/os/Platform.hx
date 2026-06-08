package androidmanager.os;

import androidmanager.jni.JNICache;

class Platform
{
    /**
	 * Retrieves the current device wallpaper as a Base64 encoded PNG string.
	 *
	 * @return The Base64 string of the wallpaper, or null if it fails.
	 */
	public static inline function getWallpaperBase64():Null<String>
	{
		final getWallpaperBase64JNI:Null<Dynamic> = JNICache.getStaticMethod('java/androidmanager/Platform', 'getWallpaperBase64', '()Ljava/lang/String;');

		if (getWallpaperBase64JNI != null)
			return getWallpaperBase64JNI();
			
		return null;
	}
}
