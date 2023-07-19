import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_scanner/components/audio_player_helper.dart';
import 'package:my_scanner/components/internet_connection.dart';
import 'package:my_scanner/screens/main_bg.dart';
import 'package:my_scanner/utils/constants.dart';
import 'package:my_scanner/utils/database_helper.dart';
import 'package:my_scanner/utils/preference_utils.dart';

class SplashController extends GetxController {
  final remoteConfig = FirebaseRemoteConfig.instance;

  late AppLifecycleReactor _appLifecycleReactor;

  void initialiseAppOpenAD() {
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor = AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
  }



  getRemoteConfig() async {
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
      initialiseAppOpenAD();
    } catch (_) {}
  }

  Future<bool> isConnectedToInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  void doSplashAdministration() async {
    PreferenceUtils.initPreference();
    DataBaseHelper.initDatabase();
    AudioHelper.loadAsset();
    getRemoteConfig();
    if (await isConnectedToInternet() == false) {
      InternetConnection.addListener();
    }

    Future.delayed(
      const Duration(seconds: 5),
      () {
        Get.off(() => const MainBG());
      },
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    doSplashAdministration();
  }
}

class AppOpenAdManager {

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  /// Load an AppOpenAd.
  void loadAd() {
    AppOpenAd.load(
      adUnitId: Constants.appOpenAd,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) async {
          // Handle the error.
          await Future.delayed(const Duration(seconds: 3));
          loadAd();
        },
      ),
    );
  }

  void showAdIfAvailable() {
    if (!isAdAvailable) {
      loadAd();
      return;
    }
    if (_isShowingAd) {
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );

    _appOpenAd?.show();
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }
}
class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}