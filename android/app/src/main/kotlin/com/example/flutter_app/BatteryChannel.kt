package com.example.flutter_app

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 *@Author oyx
 *@date 2021/5/6 17:48
 *@description
 */
class BatteryChannel(flutterEngine: BinaryMessenger, context: Context) : MethodChannel.MethodCallHandler {
    private val batteryChannelName = "cn.blogss/battery"
    private var channel: MethodChannel
    private var mContext: Context

    companion object {
        private const val TAG = "BatteryChannel"
    }

    init {
        Log.d(TAG, "init")
        channel = MethodChannel(flutterEngine, batteryChannelName)
        channel.setMethodCallHandler(this)
        mContext = context;
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.d(TAG, "onMethodCall: " + call.method)
        if (call.method == "getBatteryLevel") {
            toSetting()

        } else {
            result.notImplemented()
        }
    }

    private fun toSetting() {
        val intent: Intent = Intent()
        intent.action = android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS;
        intent.data = Uri.parse("package:" + mContext.packageName)
        mContext.startActivity(intent)

    }
}

