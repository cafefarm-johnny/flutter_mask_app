package com.example.flutter_mask

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flavor")
                .setMethodCallHandler {
                    call, result ->
                    if (call.method == "getFlavor") {
                        result.success(BuildConfig.FLAVOR)
                    } else {
                        result.notImplemented()
                    }
                }
    }
}
