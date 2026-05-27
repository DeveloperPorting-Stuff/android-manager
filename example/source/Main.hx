package;

import lime.app.Application;
#if android
import androidmanager.os.Build;
#end
class Main extends Application
{
	public function new()
	{
		super();

		#if android
		trace("Device Model " + Build.device()); // just a test
		trace("Device Manufacturer " + Build.model());
		trace("Device Industrial Design " + Build.device());
		#end
	}
}
