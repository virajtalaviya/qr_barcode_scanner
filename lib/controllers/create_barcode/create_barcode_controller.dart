import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_scanner/components/barcode_validator.dart';
import 'package:my_scanner/components/common_snackbar.dart';
import 'package:my_scanner/screens/create_barcode/edit_created_barcode.dart';
import 'package:my_scanner/utils/image_paths.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../utils/constants.dart';

class CreateBarcodeController extends GetxController {
  RxString currentValue = "Codabar".obs;
  TextEditingController textEditingController = TextEditingController();
  Symbology symbology = Codabar();
  List<CreateBarcodeDropDownContent> createBarcodeDropDownContent = [
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.textIcon,
      value: "Codabar",
      symbology: Codabar(),
    ),
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.webIcon,
      value: "Code 39 Extended",
      symbology: Code39Extended(),
    ),
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.wifiIcon,
      value: "Code 93",
      symbology: Code93(),
    ),
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.instagramIcon,
      value: "Code 128",
      symbology: Code128(),
    ),
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.whatsAppIcon,
      value: "Code 128A",
      symbology: Code128A(),
    ),
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.instagramIcon,
      value: "Code 128B",
      symbology: Code128B(),
    ),
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.instagramIcon,
      value: "Code 128C",
      symbology: Code128C(),
    ),
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.instagramIcon,
      value: "EAN-8",
      symbology: EAN8(),
    ),
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.instagramIcon,
      value: "UPC-A",
      symbology: UPCA(),
    ),
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.instagramIcon,
      value: "UPC-E",
      symbology: UPCE(),
    ),
    CreateBarcodeDropDownContent(
      imagePath: ImagePaths.instagramIcon,
      value: "EAN-13",
      symbology: EAN13(),
    ),
  ];

  void tapEventOfCreateButton(BuildContext context) {
    String snackBarContent = BarcodeValidator.validateBarcodeText(symbology, textEditingController.text.trim());

    if (textEditingController.text.trim().isEmpty) {
      showSnackBar(context, "Please enter some text");
    } else if (snackBarContent.isNotEmpty) {
      showSnackBar(context, snackBarContent, 4);
    } else {
      Get.to(
        () => EditCreatedBarcode(
          content: textEditingController.text.trim(),
          type: currentValue.value,
          symbology: symbology,
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

class CreateBarcodeDropDownContent {
  String imagePath;
  String value;
  Symbology symbology;

  CreateBarcodeDropDownContent({
    required this.imagePath,
    required this.value,
    required this.symbology,
  });
}
