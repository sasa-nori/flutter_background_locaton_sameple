package com.example.background_sample

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugins.GeneratedPluginRegistrant

class MyApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        // WorkManagerから利用できるようにEngine生成
        flutterEngine = FlutterEngine(this).apply {
            // Start executing Dart code to pre-warm the FlutterEngine.
            dartExecutor.executeDartEntrypoint(
                    DartExecutor.DartEntrypoint.createDefault()
            )
            GeneratedPluginRegistrant.registerWith(this)

            // MainActivityでも同じEngineを使えるようにキャッシュ設定
            FlutterEngineCache
                    .getInstance()
                    .put(MainActivity.FLUTTER_ENGINE_ID, this)
        }
    }

    companion object {
        var flutterEngine: FlutterEngine? = null
    }
}