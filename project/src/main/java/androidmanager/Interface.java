package java.androidmanager;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.provider.Settings;
import android.widget.Toast;
import android.widget.LinearLayout;
import android.widget.ImageView;
import android.widget.TextView;
import android.view.Gravity;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.Color;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

public class Interface extends Extension {
    public static void showToast(final String msg) {
        mainActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    LinearLayout layout = new LinearLayout(mainActivity);
                    layout.setOrientation(LinearLayout.HORIZONTAL);
                    layout.setGravity(Gravity.CENTER_VERTICAL);
                    
                    GradientDrawable shape = new GradientDrawable();
                    shape.setShape(GradientDrawable.RECTANGLE);
                    shape.setCornerRadius(100f);
                    shape.setColor(Color.parseColor("#FAFAFA"));
                    layout.setBackground(shape);
                    
                    float density = mainActivity.getResources().getDisplayMetrics().density;
                    int padH = (int) (20 * density);
                    int padV = (int) (14 * density);
                    layout.setPadding(padH, padV, padH, padV);
                    
                    ImageView icon = new ImageView(mainActivity);
                    Drawable appIcon = mainActivity.getPackageManager().getApplicationIcon(mainActivity.getApplicationInfo());
                    icon.setImageDrawable(appIcon);
                    
                    int size = (int) (24 * density);
                    LinearLayout.LayoutParams iconParams = new LinearLayout.LayoutParams(size, size);
                    iconParams.setMargins(0, 0, (int) (12 * density), 0);
                    icon.setLayoutParams(iconParams);
                    layout.addView(icon);
                    

                    TextView text = new TextView(mainActivity);
                    text.setText(msg);
                    text.setTextColor(Color.parseColor("#111111"));
                    text.setTextSize(16f);
                    layout.addView(text);
                    
                    Toast toast = new Toast(mainActivity);
                    toast.setDuration(Toast.LENGTH_SHORT);
                    toast.setView(layout);
                    toast.setGravity(Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, (int)(64 * density));
                    toast.show();
                    
                } catch (Exception e) {
                    Toast.makeText(mainActivity, msg, Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

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

    public static void confirm(final String title, final String msg, final String yes, final String no, final HaxeObject onYes, final HaxeObject onNo) {
        mainActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                AlertDialog.Builder builder = new AlertDialog.Builder(mainActivity, android.R.style.Theme_DeviceDefault_Dialog_Alert);
                builder.setTitle(title);
                builder.setMessage(msg);
                
                builder.setPositiveButton(yes, (dialog, which) -> {
                    if (onYes != null) onYes.call("onTrigger", new Object[]{});
                });
                
                builder.setNegativeButton(no, (dialog, which) -> {
                    if (onNo != null) onNo.call("onTrigger", new Object[]{});
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