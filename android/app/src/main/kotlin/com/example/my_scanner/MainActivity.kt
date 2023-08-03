// package com.app.qrbarscanner

// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin


// class MainActivity : FlutterActivity() {
//     @Override
//     fun configureFlutterEngine(flutterEngine: FlutterEngine?) {
//         super.configureFlutterEngine(flutterEngine)

//         // TODO: Register the ListTileNativeAdFactory
//         GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile",
//                 NativeAdFactorySmall(getContext()))
//         GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTileMedium",
//                 NativeAdFactoryMedium(getContext()))
//     }

//     @Override
//     fun cleanUpFlutterEngine(flutterEngine: FlutterEngine?) {
//         super.cleanUpFlutterEngine(flutterEngine)

//         // TODO: Unregister the ListTileNativeAdFactory
//         GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")
//         GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileMedium")
//     }
// }
package com.app.qrbarscanner

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}