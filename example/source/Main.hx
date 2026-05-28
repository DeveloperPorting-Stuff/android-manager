package;

import lime.app.Application;
import androidmanager.content.Context;
class Main extends Application
{
    private var isFirstFrame:Bool = true;

    public function new()
    {
        super();
    }

    override public function update(deltaTime:Int):Void 
    {
        super.update(deltaTime);

        #if android
        trace("\n--- TESTANDO STORAGE AVANÇADO ---");

        // 1. Testes de caminhos simples
        trace("Data Dir: " + Context.getDataDir());
        trace("Code Cache: " + Context.getCodeCacheDir());
        trace("No Backup: " + Context.getNoBackupFilesDir());
        trace("DB Path: " + Context.getDatabasePath("test.db"));
        trace("Stream Path: " + Context.getFileStreamPath("test.txt"));

        // 2. Testes de Arrays (usando split para reconstruir a lista)
        trace("\n--- TESTANDO EXTERNAL CACHE DIRS ---");
        var extCaches = Context.getExternalCacheDirs();
        for (i in 0...extCaches.length) {
            trace("Caminho " + i + ": " + extCaches[i]);
        }

        trace("\n--- TESTANDO EXTERNAL FILES DIRS ---");
        var extFiles = Context.getExternalFilesDirs("");
        for (i in 0...extFiles.length) {
            trace("Caminho " + i + ": " + extFiles[i]);
        }
        
        trace("--- FIM DO TESTE DE STORAGE ---\n");
        #end
    }
}