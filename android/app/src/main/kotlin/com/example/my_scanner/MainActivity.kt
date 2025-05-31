package com.app.qrbarscanner

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Register your NativeAdFactory
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "myNativeAdFactoryId", MyNativeAdFactory(context)
            // "myNativeAdFactoryId" is the ID you'll use in your Dart code.
            // MyNativeAdFactory(context) is an instance of the factory you created.
        )
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        // Unregister the factory when the engine is cleaned up.

    }
}