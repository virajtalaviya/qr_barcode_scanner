import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_scanner/components/common_snackbar.dart';
import 'package:my_scanner/screens/create_qr/edit_created_qr.dart';
import 'package:my_scanner/utils/image_paths.dart';

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

  late NativeAd nativeAd;
  RxBool nativeAdLoaded = false.obs;

  void loadNativeAD() {
    nativeAd = NativeAd(
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      factoryId: 'listTile',
      listener: NativeAdListener(
        onAdImpression: (ad) {},
        onAdClicked: (ad) {},
        onAdFailedToLoad: (ad, error) {},
        onAdClosed: (ad) {},
        onAdLoaded: (ad) {
          nativeAdLoaded.value = true;
        },
        onAdOpened: (ad) {},
        onAdWillDismissScreen: (ad) {},
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
      // nativeTemplateStyle: NativeTemplateStyle(
      //   templateType: TemplateType.small,
      //   mainBackgroundColor: Colors.purple,
      //   cornerRadius: 10.0,
      //   callToActionTextStyle: NativeTemplateTextStyle(
      //     textColor: Colors.cyan,
      //     backgroundColor: Colors.red,
      //     style: NativeTemplateFontStyle.monospace,
      //     size: 16.0,
      //   ),
      //   primaryTextStyle: NativeTemplateTextStyle(
      //     textColor: Colors.red,
      //     backgroundColor: Colors.cyan,
      //     style: NativeTemplateFontStyle.italic,
      //     size: 16.0,
      //   ),
      //   secondaryTextStyle: NativeTemplateTextStyle(
      //     textColor: Colors.green,
      //     backgroundColor: Colors.black,
      //     style: NativeTemplateFontStyle.bold,
      //     size: 16.0,
      //   ),
      //   tertiaryTextStyle: NativeTemplateTextStyle(
      //     textColor: Colors.brown,
      //     backgroundColor: Colors.amber,
      //     style: NativeTemplateFontStyle.normal,
      //     size: 16.0,
      //   ),
      // ),
    );
    nativeAd.load();
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
