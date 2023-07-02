package com.example.basic_platform_channel

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager

class MainActivity: FlutterActivity() {
  private val CHANNEL = "sampleChannel"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        // This method is invoked on the main thread.
        call, result ->
        if (call.method == "isCharging") {
            val batteryState: String 

            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            val state = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_STATUS);

            when(state){
                BatteryManager.BATTERY_STATUS_UNKNOWN -> batteryState = "Unknown"
                BatteryManager.BATTERY_STATUS_CHARGING -> batteryState = "Charging"
                BatteryManager.BATTERY_STATUS_DISCHARGING -> batteryState = "Not charging"
                BatteryManager.BATTERY_STATUS_NOT_CHARGING -> batteryState = "Not charging"
                BatteryManager.BATTERY_STATUS_FULL -> batteryState = "Fully-charged"
                else -> batteryState = "Unknown"
            }

            result.success(batteryState)
        } else {
          result.notImplemented()
        }
      }
  }
}
 