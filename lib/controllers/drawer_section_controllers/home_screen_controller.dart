import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_scanner/screens/create_barcode/create_barcode.dart';
import 'package:my_scanner/screens/create_qr/create_qr_screen.dart';
import 'package:my_scanner/screens/scan/scan_barcode_qr.dart';
import 'package:my_scanner/utils/constants.dart';

class HomeController extends GetxController {
  int loadAttempt = 0;
  InterstitialAd? interstitialAd;

  int screenCount = 0;

  void navigation() {
    if (screenCount == 0) {
      Get.to(() => const CreateQRScreen());
    } else if (screenCount == 1) {
      Get.to(() => const CreateBarcodeScreen());
    } else if (screenCount == 2) {
      Get.to(() => const ScanBarcodeAndQR());
    }
  }

  void loadInterstitialAD() {
    InterstitialAd.load(
      adUnitId: Constants.interstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdClicked: (ad) {},
            onAdDismissedFullScreenContent: (ad) {
              navigation();
              interstitialAd?.dispose();
              interstitialAd = null;
              loadInterstitialAD();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              navigation();
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


  @override
  void onInit() {
    super.onInit();
    if (Constants.interstitialAdId != "") {
      loadInterstitialAD();
    }
  }
}
