package com.example.background_sample

import android.Manifest
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import ss_n.common_ktx.extension.hasPermission

class MainActivity : FlutterActivity() {

    override fun getCachedEngineId(): String = FLUTTER_ENGINE_ID

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val manager = flutterEngine.dartExecutor.binaryMessenger
        val channel = MethodChannel(manager, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "requestLocation" -> {
                    val methodName = call.argument<String>(MyCoroutineWorker.KEY_METHOD_NAME) ?: ""
                    applicationContext?.let {
                        MyCoroutineWorker.startOneTimeWorker(it, methodName)
                        result.success("start $methodName")
                    } ?: result.error("404", "MethodName is Null", "Not found MethodName")
                }
                "checkPermissions" -> {
                    checkPermissions()
                    result.success("Start ${call.method}")
                }
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                }
                METHOD_START_BACKGROUND_SERVICE -> {
                    val methodName = call.argument<String>(MyCoroutineWorker.KEY_METHOD_NAME)
                    val interval = call.argument<Int>(MyCoroutineWorker.KEY_MINUTES)
                    applicationContext?.let {
                        BackgroundJobReceiver.setBackgroundJob(applicationContext, methodName, interval
                                ?: 15)
                        result.success("start Worker")
                    } ?: result.error("404", "Context is Null", "Not found Context")
                }
                METHOD_CANCEL_BACKGROUND_SERVICE -> {
                    applicationContext?.let {
                        BackgroundJobReceiver.clearBackgroundJob(applicationContext)
                        result.success("cancel Worker")
                    } ?: result.error("404", "Context is Null", "Not found Context")
                }
            }
        }
    }

    private fun checkPermissions() {
        val permissions = arrayOf(
                Manifest.permission.ACCESS_COARSE_LOCATION,
                Manifest.permission.ACCESS_FINE_LOCATION
        )
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q) {
            permissions.plus(Manifest.permission.ACCESS_BACKGROUND_LOCATION)
        }
        if (!hasPermission(permissions)) {

            requestPermissions(permissions, 0)
        }
    }

    companion object {
        const val CHANNEL = "com.example.background_sample/background_service"

        const val METHOD_START_BACKGROUND_SERVICE = "startBackgroundService"
        const val METHOD_CANCEL_BACKGROUND_SERVICE = "cancelBackgroundService"

        const val FLUTTER_ENGINE_ID = "com.example.background_sample.engine"
    }
}
