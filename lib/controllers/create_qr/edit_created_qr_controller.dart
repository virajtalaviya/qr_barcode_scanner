import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_scanner/components/common_loader.dart';
import 'package:my_scanner/screens/create_qr/saved_qr.dart';
import 'package:my_scanner/utils/constants.dart';
import 'package:my_scanner/utils/database_helper.dart';

class EditCreatedQRController extends GetxController {
  late BuildContext context;
  late String title;
  late String content;

  List<Color> codeFGBGColor = const [
    Color(0xff000000),
    Color(0xffFFFFFF),
    Color(0xffFF2431),
    Color(0xffFF5924),
    Color(0xff09AD0F),
    Color(0xffFFB800),
    Color(0xffFF007A),
    Color(0xff8F00FF),
    Color(0xff0075FF),
  ];

  RxInt currentGroundIndex = 0.obs;

  RxInt currentForeGroundColorIndex = 0.obs;
  RxInt currentBackGroundColorIndex = 1.obs;

  void changeIndexOfGround() {
    if (currentGroundIndex.value == 0) {
      currentGroundIndex.value = 1;
    } else {
      currentGroundIndex.value = 0;
    }
  }

  void changeIndexOfColor(int index) {
    if (currentGroundIndex.value == 0) {
      // This will make changes in Foreground
      currentForeGroundColorIndex.value = index;
    } else {
      // This will make changes in Background
      currentBackGroundColorIndex.value = index;
    }
  }

  final GlobalKey globalKey = GlobalKey();

  Future<Uint8List?> _capturePng() async {
    RenderRepaintBoundary? boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    ui.Image? image = await boundary?.toImage();
    ByteData? byteData = await image?.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    return pngBytes;
  }

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
              saveQRCode();
              interstitialAd?.dispose();
              interstitialAd = null;
              loadInterstitialAD();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              saveQRCode();
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

  void saveQRCode() async {
    showLoader(context);

    Uint8List? qrImage = await _capturePng();
    String intListString = qrImage?.join(',') ?? "";

    DataBaseHelper.realm.write(() {
      DataBaseHelper.realm.add<CreatedCode>(
        CreatedCode(
          title: title,
          content: content,
          bytes: intListString,
          qrType: "QR Code",
        ),
      );
    });
    if (context.mounted) {
      Navigator.pop(context);
    }
    Get.to(
      () => SavedQRCode(
        qrImage: qrImage,
        createdCode: CreatedCode(
          title: title,
          content: content,
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    if (Constants.interstitialAdId != "") {
      loadInterstitialAD();
    }
  }
}
