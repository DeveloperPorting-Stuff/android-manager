package;

import lime.app.Application;
#if android
import androidmanager.tools.HardwareUtils;
#end
class Main extends Application
{
	public function new()
	{
		super();

		#if android
		trace("Device Model" + HardwareUtils.getDeviceModel()); // just a test
		trace("Device Manufacturer" + HardwareUtils.getDeviceManufacturer());
		#else
		trace("only works on Android Devices!")
		#end
	}
}
