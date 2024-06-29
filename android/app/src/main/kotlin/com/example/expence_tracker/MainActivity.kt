package com.example.expence_tracker

import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  private val CHANNEL = "exact_alarm_permission"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
      if (call.method == "hasExactAlarmPermission") {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
          val alarmManager = getSystemService(ALARM_SERVICE) as android.app.AlarmManager
          result.success(alarmManager.canScheduleExactAlarms())
        } else {
          result.success(true) // Permission is not required for lower versions
        }
      } else {
        result.notImplemented()
      }
    }
  }
}