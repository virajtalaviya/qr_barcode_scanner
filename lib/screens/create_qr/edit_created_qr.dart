import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/controllers/create_qr/edit_created_qr_controller.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class EditCreatedQR extends StatelessWidget {
  const EditCreatedQR({
    Key? key,
    required this.content,
    required this.type,
  }) : super(key: key);

  final String content;
  final String type;

  @override
  Widget build(BuildContext context) {
    EditCreatedQRController editCreatedQRController = Get.put(EditCreatedQRController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            ImagePaths.backIcon,
            height: 25,
          ),
        ),
        title: const Text(
          "Edit",
          style: TextStyle(
            color: Colors.black,
            fontFamily: FontFamily.productSansBold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              editCreatedQRController.saveQRCode(context, type, content);
            },
            child: const Text(
              "Save",
              style: TextStyle(
                color: ColorUtils.activeColor,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: RepaintBoundary(
          key: editCreatedQRController.globalKey,
          child: Obx(() {
            return Container(
              height: 250,
              width: 250,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: editCreatedQRController.codeFGBGColor[editCreatedQRController.currentBackGroundColorIndex.value],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorUtils.splashLogoBorder),
              ),
              child: SfBarcodeGenerator(
                value: content,
                symbology: QRCode(),
                barColor:
                    editCreatedQRController.codeFGBGColor[editCreatedQRController.currentForeGroundColorIndex.value],
              ),
            );
          }),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: ColorUtils.tbBGColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    editCreatedQRController.changeIndexOfGround();
                  },
                  child: Obx(() {
                    return Text(
                      "Foreground",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.productSansBold,
                        color: editCreatedQRController.currentGroundIndex.value == 0
                            ? ColorUtils.activeColor
                            : ColorUtils.thumbDeActiveColor,
                      ),
                    );
                  }),
                ),
                TextButton(
                  onPressed: () {
                    editCreatedQRController.changeIndexOfGround();
                  },
                  child: Obx(() {
                    return Text(
                      "Background",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.productSansBold,
                        color: editCreatedQRController.currentGroundIndex.value == 1
                            ? ColorUtils.activeColor
                            : ColorUtils.thumbDeActiveColor,
                      ),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  editCreatedQRController.codeFGBGColor.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        editCreatedQRController.changeIndexOfColor(index);
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: editCreatedQRController.codeFGBGColor[index],
                          shape: BoxShape.circle,
                        ),
                        child: Obx(() {
                          if (editCreatedQRController.currentGroundIndex.value == 0) {
                            return editCreatedQRController.currentForeGroundColorIndex.value == index
                                ? Icon(
                                    Icons.check,
                                    color: editCreatedQRController.currentForeGroundColorIndex.value == 1
                                        ? Colors.black
                                        : Colors.white,
                                    size: 15,
                                  )
                                : const SizedBox();
                          }
                          return editCreatedQRController.currentBackGroundColorIndex.value == index
                              ? Icon(
                                  Icons.check,
                                  color: editCreatedQRController.currentBackGroundColorIndex.value == 1
                                      ? Colors.black
                                      : Colors.white,
                                  size: 15,
                                )
                              : const SizedBox();
                        }),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 40,
              decoration: const BoxDecoration(color: ColorUtils.splashLogoBG),
              child: TextButton(
                onPressed: () {
                  Get.close(2);
                },
                child: const Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: FontFamily.productSansBold,
                      color: ColorUtils.thumbDeActiveColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
