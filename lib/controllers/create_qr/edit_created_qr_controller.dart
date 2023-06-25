import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_scanner/components/common_loader.dart';
import 'package:my_scanner/screens/create_qr/saved_qr.dart';
import 'package:my_scanner/utils/database_helper.dart';

class EditCreatedQRController extends GetxController {
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

  void saveQRCode(BuildContext context, String title, String content) async {
    showLoader(context);

    Uint8List? qrImage = await _capturePng();
    String intListString = qrImage?.join(',') ?? "";

    DataBaseHelper.realm.write(() {
      DataBaseHelper.realm.add<CreatedQRCode>(
        CreatedQRCode(
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
        createdQRCode: CreatedQRCode(
          title: title,
          content: content,
        ),
      ),
    );
  }
}
