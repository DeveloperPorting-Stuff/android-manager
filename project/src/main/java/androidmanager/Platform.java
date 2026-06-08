package java.androidmanager;

import android.app.WallpaperManager;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.provider.Settings;
import android.util.Base64;
import android.util.Log;
import java.io.ByteArrayOutputStream;
import org.haxe.extension.Extension; 

public class Platform extends Extension {

    private static final String LOG_TAG = "SystemManager";

    public static String getWallpaperBase64() {
        try {
            Context context = Extension.mainContext;

            if (context == null) {
                Log.e(LOG_TAG, "Error: main context null.");
                return null;
            }

            final WallpaperManager wallpaperManager = WallpaperManager.getInstance(context);
            final Drawable wallpaperDrawable = wallpaperManager.getDrawable();

            if (wallpaperDrawable == null) {
                return null;
            }

            Bitmap originalBitmap;
            
            if (wallpaperDrawable instanceof BitmapDrawable) {
                originalBitmap = ((BitmapDrawable) wallpaperDrawable).getBitmap();
            } else {
                int width = Math.max(1, wallpaperDrawable.getIntrinsicWidth());
                int height = Math.max(1, wallpaperDrawable.getIntrinsicHeight());
                
                originalBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                final Canvas canvas = new Canvas(originalBitmap);
                
                wallpaperDrawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
                wallpaperDrawable.draw(canvas);
            }

            Matrix matrix = new Matrix();
            matrix.postRotate(90); 
            
            Bitmap rotatedBitmap = Bitmap.createBitmap(
                originalBitmap, 
                0, 0, 
                originalBitmap.getWidth(), originalBitmap.getHeight(), 
                matrix, 
                true
            );

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            rotatedBitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
            byte[] byteArray = outputStream.toByteArray();
            
            return Base64.encodeToString(byteArray, Base64.NO_WRAP);
            
        } catch (Exception e) {
            Log.e(LOG_TAG, "Error processing wallpaper: " + e.toString()); 
            return null;
        }
    }

    public static void openSettingsMenu(String actionName, int reqCode) {
        if (mainActivity == null) return;
        try {
            Intent configIntent = new Intent(actionName);
            
            boolean isStorageManage = actionName.equals("android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
            
            if (isStorageManage && mainContext != null) {
                String appPackage = "package:" + mainContext.getPackageName();
                configIntent.setData(Uri.parse(appPackage));
            }
            mainActivity.startActivityForResult(configIntent, reqCode);
            
        } catch (Exception exception) {
            Log.w(LOG_TAG, "Action not supported, opening main settings.");
            try {
                Intent fallback = new Intent(Settings.ACTION_SETTINGS);
                mainActivity.startActivityForResult(fallback, reqCode);
            } catch (Exception fatalError) {
                fatalError.printStackTrace();
            }
        }
    }
}