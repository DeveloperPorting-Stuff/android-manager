package;

import lime.app.Application;
#if android
import androidmanager.tools.PermissionUtils;
#end

class Main extends Application
{
    private var isFirstFrame:Bool = true;

    public function new()
    {
        super();
    }
}