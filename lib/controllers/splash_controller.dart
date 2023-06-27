import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:my_scanner/components/audio_player_helper.dart';
import 'package:my_scanner/components/internet_connection.dart';
import 'package:my_scanner/screens/main_bg.dart';
import 'package:my_scanner/utils/constants.dart';
import 'package:my_scanner/utils/database_helper.dart';
import 'package:my_scanner/utils/preference_utils.dart';

class SplashController extends GetxController {
  final remoteConfig = FirebaseRemoteConfig.instance;

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
