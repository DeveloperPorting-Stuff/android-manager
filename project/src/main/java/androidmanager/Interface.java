package java.androidmanager;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.provider.Settings;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

public class Interface extends Extension {
    public static void alert(final String title, final String msg, final String btn, final HaxeObject callback) {
    mainActivity.runOnUiThread(new Runnable() {
        @Override
        public void run() {
            AlertDialog.Builder builder = new AlertDialog.Builder(mainActivity, android.R.style.Theme_DeviceDefault_Dialog_Alert);
            
            builder.setTitle(title);
            builder.setMessage(msg);
            builder.setPositiveButton(btn, (dialog, which) -> {
                if (callback != null) callback.call("onTrigger", new Object[]{});
            });
            builder.setCancelable(false);
            builder.show();
        }
    });
}

public static void navigate(final String action, final int code) {
      mainActivity.runOnUiThread(() -> {
            try {
                Intent intent = new Intent(action);
                if (action.equals(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION)) {
                    intent.setData(Uri.parse("package:" + mainContext.getPackageName()));
                }
                mainActivity.startActivityForResult(intent, code);
            } catch (Exception e) {
                mainActivity.startActivityForResult(new Intent(Settings.ACTION_SETTINGS), code);
            }
        });
    }
}