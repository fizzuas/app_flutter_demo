package com.example.flutter_app

import android.annotation.TargetApi
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 *@Author oyx
 *@date 2021/5/6 19:44
 *@description
 */
class PermissionChannel(flutterEngine: BinaryMessenger, context: Context) : MethodChannel.MethodCallHandler {
    private val batteryChannelName = "com.kydz/permission"
    private var channel: MethodChannel
    private var mContext: Context

    companion object {
        private const val TAG = "PermissionChannel"
    }

    init {
        Log.d(TAG, "init")
        channel = MethodChannel(flutterEngine, batteryChannelName)
        channel.setMethodCallHandler(this)
        mContext = context;
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.d(TAG, "onMethodCall: " + call.method)
        if (call.method == "toPermissionSetting") {
            toSetting()
        } else {
            result.notImplemented()
        }
    }

    @TargetApi(Build.VERSION_CODES.GINGERBREAD)
    private fun toSetting() {
        val intent: Intent = Intent()
        intent.action = android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS;
        intent.data = Uri.parse("package:" + mContext.packageName)
        mContext.startActivity(intent)

    }
}