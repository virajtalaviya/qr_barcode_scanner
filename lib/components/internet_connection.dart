import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:my_scanner/utils/constants.dart';

class InternetConnection {
  static final Connectivity _connectivity = Connectivity();
  static late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static final remoteConfig = FirebaseRemoteConfig.instance;

  static void getRemoteConfig() async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 30),
        ),
      );
      await remoteConfig.fetchAndActivate();
      Constants.interstitialAdId = remoteConfig.getString("interstitial_ad_id");
      Constants.bannerAdId = remoteConfig.getString("banner_ad_id");
      Constants.appOpenAd = remoteConfig.getString("app_open_ad");
      Constants.appPlayStoreURL = remoteConfig.getString("appPlayStoreURL");
    } catch (_) {}
  }

  static bool gotConnection(ConnectivityResult result) {
    if (result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }

  static  void addListener() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((event) {
      bool connected = gotConnection(event);
      if (connected) {
        getRemoteConfig();
        _connectivitySubscription.cancel();
      }
    });
  }
}
