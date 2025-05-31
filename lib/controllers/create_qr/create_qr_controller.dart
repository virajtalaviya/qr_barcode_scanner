import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_scanner/components/common_snackbar.dart';
import 'package:my_scanner/screens/create_qr/edit_created_qr.dart';
import 'package:my_scanner/utils/image_paths.dart';

import '../../utils/constants.dart';

class CreateQRController extends GetxController {
  RxString currentValue = "Text".obs;
  TextEditingController textEditingController = TextEditingController();
  List<CreateQRDropDownContent> createQRDropDownContent = [
    CreateQRDropDownContent(
      imagePath: ImagePaths.textIcon,
      value: "Text",
    ),
    CreateQRDropDownContent(
      imagePath: ImagePaths.webIcon,
      value: "Website",
    ),
    CreateQRDropDownContent(
      imagePath: ImagePaths.wifiIcon,
      value: "Wi-fi",
    ),
    CreateQRDropDownContent(
      imagePath: ImagePaths.whatsAppIcon,
      value: "Whatsapp",
    ),
    CreateQRDropDownContent(
      imagePath: ImagePaths.instagramIcon,
      value: "Instagram",
    ),
  ];

  void tapEventOfCreateButton(BuildContext context) {
    if (textEditingController.text.trim().isEmpty) {
      showSnackBar(context, "Please enter some text");
    } else {
      Get.to(
        () => EditCreatedQR(
          content: textEditingController.text.trim(),
          type: currentValue.value,
        ),
      );
    }
  }

  NativeAd? nativeAd;
  RxBool isNativeAdLoaded = false.obs;

  void loadNativeAD() {
    nativeAd = NativeAd(
      adUnitId: Constants.nativeAD,
      factoryId: "myNativeAdFactoryId",
      listener: NativeAdListener(
        onAdImpression: (ad) {},
        onAdClicked: (ad) {},
        onAdFailedToLoad: (ad, error) {},
        onAdClosed: (ad) {},
        onAdLoaded: (ad) {
          isNativeAdLoaded.value = true;
        },
        onAdOpened: (ad) {},
        onAdWillDismissScreen: (ad) {},
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
      ),
    );
    nativeAd?.load();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadNativeAD();
  }
}

class CreateQRDropDownContent {
  String imagePath;
  String value;

  CreateQRDropDownContent({
    required this.imagePath,
    required this.value,
  });
}
