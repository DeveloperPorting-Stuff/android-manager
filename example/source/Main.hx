package;

import androidmanager.os.Environment;
import androidmanager.tools.Lifecycle;
import androidmanager.tools.PermissionUtils;
#if openfl
import openfl.display.Sprite;
#end

class Main #if openfl extends Sprite #end {
	public function new() {
		#if openfl
		super();
		#end

		androidmanager.content.Interface.showToast("Eu amo meu love");

		trace(androidmanager.content.Context.dataDir);
		trace(androidmanager.content.Context.internalFilesDir);
		trace(androidmanager.content.Context.obbDir);
		trace(Environment.getDataDirectory());
		trace(androidmanager.content.Context.externalCacheDirs);

		Lifecycle.addOnExit(onAppClosing);

		PermissionUtils.requestPermissions(['READ_EXTERNAL_STORAGE', 'WRITE_EXTERNAL_STORAGE']);
	}

	private function onAppClosing():Void {
        trace("te amo meu amor");
    }
}
