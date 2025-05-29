import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection {
  static final Connectivity _connectivity = Connectivity();
  static late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  // static final remoteConfig = FirebaseRemoteConfig.instance;

  // static void getRemoteConfig() async {
  //   try {
  //     await remoteConfig.setConfigSettings(
  //       RemoteConfigSettings(
  //         fetchTimeout: const Duration(seconds: 10),
  //         minimumFetchInterval: const Duration(seconds: 30),
  //       ),
  //     );
  //     await remoteConfig.fetchAndActivate();
  //     Constants.interstitialAdId = remoteConfig.getString("interstitial_ad_id");
  //     Constants.bannerAdId = remoteConfig.getString("banner_ad_id");
  //     Constants.appOpenAd = remoteConfig.getString("app_open_ad");
  //     Constants.appPlayStoreURL = remoteConfig.getString("appPlayStoreURL");
  //   } catch (_) {}
  // }

  static bool gotConnection(List<ConnectivityResult> result) {

    if(result.contains(ConnectivityResult.ethernet)){
      return true;
    }
    if(result.contains(ConnectivityResult.wifi)){
      return true;
    }
    if(result.contains(ConnectivityResult.mobile)){
      return true;
    }
    return false;
  }

  static  void addListener() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((event) {
      bool connected = gotConnection(event);
      if (connected) {
        // getRemoteConfig();
        _connectivitySubscription.cancel();
      }
    });
  }
}
