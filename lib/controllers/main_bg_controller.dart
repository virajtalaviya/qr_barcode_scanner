import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_scanner/components/common_snackbar.dart';
import 'package:my_scanner/controllers/drawer_section_controllers/history_controller.dart';
import 'package:my_scanner/screens/drawer_screens/history.dart';
import 'package:my_scanner/screens/drawer_screens/home_screen.dart';
import 'package:my_scanner/screens/drawer_screens/settings.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/constants.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';
import 'package:my_scanner/widgets/custom_app_bars/history_app_bar.dart';
import 'package:my_scanner/widgets/custom_app_bars/home_app_bar.dart';
import 'package:my_scanner/widgets/custom_app_bars/settings_app_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MainBGController extends GetxController {
  late BuildContext context;
  Widget? currentWidget;
  PreferredSizeWidget? currentAppBar;
  HistoryController historyController = Get.put(HistoryController());
  int currentIndex = 0;
  late GlobalKey<ScaffoldState> scaffoldKey;

  int loadAttempt = 0;
  InterstitialAd? interstitialAd;

  void loadInterstitialAD() {
    InterstitialAd.load(
      adUnitId: Constants.interstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              Constants.showAppOpen = false;
            },
            onAdImpression: (ad) {},
            onAdClicked: (ad) {},
            onAdDismissedFullScreenContent: (ad) {
              Constants.showAppOpen = true;
              drawerTapEvents();
              interstitialAd?.dispose();
              interstitialAd = null;
              loadInterstitialAD();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              drawerTapEvents();
              ad.dispose();
              interstitialAd = null;
              loadInterstitialAD();
            },
          );
        },
        onAdFailedToLoad: (error) {
          loadAttempt = loadAttempt + 1;
          if (loadAttempt <= 3) {
            loadInterstitialAD();
          } else {
            Future.delayed(const Duration(seconds: 10), () {
              loadAttempt = 0;
            });
          }
        },
      ),
    );
  }

  List<DrawerElements> drawerContent = [
    DrawerElements(
      icon: ImagePaths.drawerHome,
      title: "Home",
    ),
    DrawerElements(
      icon: ImagePaths.drawerHistory,
      title: "History",
    ),
    DrawerElements(
      icon: ImagePaths.drawerFeedBack,
      title: "Feedback",
    ),
    DrawerElements(
      icon: ImagePaths.drawerShareApp,
      title: "Share app",
    ),
    DrawerElements(
      icon: ImagePaths.drawerRateUs,
      title: "Rate us",
    ),
    DrawerElements(
      icon: ImagePaths.drawerSetting,
      title: "Settings",
    ),
  ];

  void drawerTapEvents() {
    Get.back();
    switch (currentIndex) {
      case 0:
        currentWidget = const HomeScreen();
        currentAppBar = HomeAppBar(scaffoldKey: scaffoldKey);
        update();
        break;
      case 1:
        historyController.getScannedQR();
        historyController.getCreatedQRCode();
        currentWidget = History(historyController: historyController);
        currentAppBar = HistoryAppBar(scaffoldKey: scaffoldKey, historyController: historyController);
        update();
        break;
      case 2:
        if (Constants.appPlayStoreURL == "") {
          showSnackBar(context, "Can not open play store to give feedback, make sure you are connected to internet and retry after some time");
        } else {
          launchUrlString(Constants.appPlayStoreURL, mode: LaunchMode.externalApplication);
        }
        break;
      case 3:
        if (Constants.appPlayStoreURL == "") {
          showSnackBar(context, "Can not share this app, make sure you are connected to internet and retry after some time");
        } else {
          Share.share(Constants.appPlayStoreURL);
        }
        break;
      case 4:
        if (Constants.appPlayStoreURL == "") {
          showSnackBar(context, "Can not open play store to give rate, make sure you are connected to internet and retry after some time");
        } else {
          launchUrlString(Constants.appPlayStoreURL, mode: LaunchMode.externalApplication);
        }
        break;
      case 5:
        currentWidget = const Settings();
        currentAppBar = SettingsAppBar(scaffoldKey: scaffoldKey);
        update();
        break;
    }
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

  void showInternetPopUp() async {
    bool ifItHasInternet = await isConnectedToInternet();
    if (ifItHasInternet == false) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: const Text(
            "Turn on internet for better experience",
            style: TextStyle(
              fontFamily: FontFamily.productSansRegular,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  color: ColorUtils.activeColor,
                  fontFamily: FontFamily.productSansRegular,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Constants.interstitialAdId != "") {
      loadInterstitialAD();
    }
    showInternetPopUp();
  }
}

class DrawerElements {
  String icon;
  String title;

  DrawerElements({
    required this.icon,
    required this.title,
  });
}
