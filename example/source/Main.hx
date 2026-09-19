package;

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
		trace(androidmanager.content.Context.externalDataDir);
	}
}
