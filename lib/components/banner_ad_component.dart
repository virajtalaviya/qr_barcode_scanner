import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_scanner/utils/constants.dart';

class BannerComponent extends StatefulWidget {
  const BannerComponent({Key? key}) : super(key: key);

  @override
  State<BannerComponent> createState() => _BannerComponentState();
}

class _BannerComponentState extends State<BannerComponent> {
  BannerAd? bannerAd;
  int loadAttempt = 0;

  void loadBanner() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Constants.bannerAdId,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          if (loadAttempt <= 3) {
            loadBanner();
          }
        },
        onAdLoaded: (ad) {
          setState(() {});
        },
      ),
      request: const AdRequest(),
    );

    if (bannerAd != null) {
      bannerAd?.load();
      loadAttempt++;
    }
  }

  @override
  void initState() {
    super.initState();
    if (Constants.bannerAdId != "") {
      loadBanner();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AdSize.banner.height.toDouble(),
      child: bannerAd != null ? AdWidget(ad: bannerAd!) : const SizedBox(),
    );
  }
}
