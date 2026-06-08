package;

import openfl.display.Sprite;
import androidmanager.os.Platform;

class Main extends Sprite
{
    public function new()
    {
        super();
        
        try {
            Platform.requestSetting("WIFI_SETTINGS");
        } catch(e:Dynamic) { // love stars
        }
    }
}