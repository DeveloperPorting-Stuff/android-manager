package java.androidmanager;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;
import android.os.BatteryManager;

public class Battery extends Extension {

    private static final String ACTION_BATTERY_CHANGED = Intent.ACTION_BATTERY_CHANGED;

    private static Battery _instance = null;
    private static HaxeObject _batteryCallback = null;
    private static BroadcastReceiver _receiver = null;
    private static boolean _listening = false;

    public static void init() {
        if (_instance != null)
            return;

        _instance = new Battery();
    }

    public static void setCallback(HaxeObject callback) {
        _batteryCallback = callback;
    }

    private static Intent getBatteryIntent() {
        if (Extension.mainActivity == null)
            return null;

        return Extension.mainActivity.registerReceiver(
            null,
            new IntentFilter(ACTION_BATTERY_CHANGED)
        );
    }

    public static int getLevel() {
        Intent intent = getBatteryIntent();
        if (intent == null)
            return -1;

        int level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
        int scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);

        if (level == -1 || scale == -1)
            return -1;

        return (int) ((level / (float) scale) * 100);
    }

    public static int getStatus() {
        Intent intent = getBatteryIntent();
        if (intent == null)
            return BatteryManager.BATTERY_STATUS_UNKNOWN;

        return intent.getIntExtra(BatteryManager.EXTRA_STATUS, BatteryManager.BATTERY_STATUS_UNKNOWN);
    }

    public static int getHealth() {
        Intent intent = getBatteryIntent();
        if (intent == null)
            return BatteryManager.BATTERY_HEALTH_UNKNOWN;

        return intent.getIntExtra(BatteryManager.EXTRA_HEALTH, BatteryManager.BATTERY_HEALTH_UNKNOWN);
    }

    public static int getPlugged() {
        Intent intent = getBatteryIntent();
        if (intent == null)
            return -1;

        return intent.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1);
    }

    public static float getTemperature() {
        Intent intent = getBatteryIntent();
        if (intent == null)
            return -1f;

        int temp = intent.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1);
        return temp == -1 ? -1f : temp / 10.0f;
    }

    public static int getVoltage() {
        Intent intent = getBatteryIntent();
        if (intent == null)
            return -1;

        return intent.getIntExtra(BatteryManager.EXTRA_VOLTAGE, -1);
    }

    public static String getTechnology() {
        Intent intent = getBatteryIntent();
        if (intent == null)
            return null;

        return intent.getStringExtra(BatteryManager.EXTRA_TECHNOLOGY);
    }

    public static boolean isCharging() {
        int status = getStatus();
        return status == BatteryManager.BATTERY_STATUS_CHARGING
            || status == BatteryManager.BATTERY_STATUS_FULL;
    }

   public static boolean isLow() {
        int level = getLevel();
        if (level == -1)
            return false;

        if (Build.VERSION.SDK_INT >= 23 && Extension.mainActivity != null) {
            android.os.PowerManager pm = (android.os.PowerManager)
                Extension.mainActivity.getSystemService(Context.POWER_SERVICE);
            if (pm != null)
                return pm.isDeviceIdleMode() || level <= 15;
        }

        return level <= 15;
    }

    public static boolean isPowerSaveMode() {
        if (Extension.mainActivity == null)
            return false;

        android.os.PowerManager pm = (android.os.PowerManager)
            Extension.mainActivity.getSystemService(Context.POWER_SERVICE);

        return pm != null && pm.isPowerSaveMode();
    }

    public static long getChargeTimeRemaining() {
        if (Build.VERSION.SDK_INT < 28 || Extension.mainActivity == null)
            return -1;

        BatteryManager bm = (BatteryManager)
            Extension.mainActivity.getSystemService(Context.BATTERY_SERVICE);

        return bm != null ? bm.computeChargeTimeRemaining() : -1;
    }

    public static void startListening() {
        if (_listening || Extension.mainActivity == null)
            return;

        _receiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                if (_batteryCallback == null)
                    return;

                final int level = getLevel();
                final int status = getStatus();
                final int health = getHealth();
                final int plugged = getPlugged();
                final float temperature = getTemperature();
                final boolean charging = isCharging();
                final boolean low = isLow();
                final boolean powerSave = isPowerSaveMode();

                Extension.callbackHandler.post(new Runnable() {
                    @Override
                    public void run() {
                        _batteryCallback.call("onBatteryChanged", new Object[]{
                            level, status, health, plugged,
                            temperature, charging, low, powerSave
                        });
                    }
                });
            }
        };

        Extension.mainActivity.registerReceiver(
            _receiver,
            new IntentFilter(ACTION_BATTERY_CHANGED)
        );

        _listening = true;
    }

    public static void stopListening() {
        if (!_listening || Extension.mainActivity == null || _receiver == null)
            return;

        Extension.mainActivity.unregisterReceiver(_receiver);
        _receiver = null;
        _listening = false;
    }

    public static boolean isListening() {
        return _listening;
    }
}
