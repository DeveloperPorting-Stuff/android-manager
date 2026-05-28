package;

import lime.app.Application;
#if android
import androidmanager.os.Build;
#end

class Main extends Application
{
    private var isFirstFrame:Bool = true;

    public function new()
    {
        super();
    }
}