import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
}

class CreateQRDropDownContent {
  String imagePath;
  String value;

  CreateQRDropDownContent({
    required this.imagePath,
    required this.value,
  });
}


