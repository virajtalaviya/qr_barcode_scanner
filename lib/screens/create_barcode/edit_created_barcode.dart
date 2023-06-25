import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/controllers/create_barcode/edit_barcode_controller.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class EditCreatedBarcode extends StatelessWidget {
  const EditCreatedBarcode({
    Key? key,
    required this.content,
    required this.type,
    required this.symbology,
  }) : super(key: key);

  final String content;
  final String type;
  final Symbology symbology;

  @override
  Widget build(BuildContext context) {
    EditCreatedBarcodeController editCreatedBarcodeController = Get.put(EditCreatedBarcodeController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                editCreatedBarcodeController.saveBarCode(context, type, content);
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
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(0, -0.5),
              child: RepaintBoundary(
                key: editCreatedBarcodeController.globalKey,
                child: Obx(() {
                  return Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: editCreatedBarcodeController
                          .codeFGBGColor[editCreatedBarcodeController.currentBackGroundColorIndex.value],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorUtils.splashLogoBorder),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Obx(() {
                          return Text(
                            editCreatedBarcodeController.displayText.value,
                            style: const TextStyle(
                              fontFamily: FontFamily.productSansBold,
                              fontSize: 14,
                            ),
                          );
                        }),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 150,
                          width: 250,
                          child: SfBarcodeGenerator(
                            value: content,
                            symbology: symbology,
                            barColor: editCreatedBarcodeController
                                .codeFGBGColor[editCreatedBarcodeController.currentForeGroundColorIndex.value],
                          ),
                          // child: BarcodeWidget(
                          //   data: content,
                          //   barcode: Barcode.codabar(),
                          // ),
                        ),
                        // const SizedBox(height: 5),
                        // const Text(
                        //   "3A576B",
                        //   style: TextStyle(
                        //     fontFamily: FontFamily.productSansBold,
                        //     fontSize: 18,
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() {
                if (editCreatedBarcodeController.currentBottomWidget.value == "MainBottomContent") {
                  ///   Main bottom content -> (Colors and Fonts)
                  return Container(
                    height: 70,
                    decoration: const BoxDecoration(
                      color: ColorUtils.tbBGColor,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              editCreatedBarcodeController.currentBottomWidget.value = "ColorContent";
                            },
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(ImagePaths.colorIcon, height: 25, width: 25),
                                  const Text(
                                    "Color",
                                    style: TextStyle(fontSize: 14, fontFamily: FontFamily.productSansBold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              editCreatedBarcodeController.currentBottomWidget.value = "FontContent";
                            },
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(ImagePaths.fontIcon, height: 25, width: 25),
                                  const Text(
                                    "Fonts",
                                    style: TextStyle(fontSize: 14, fontFamily: FontFamily.productSansBold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (editCreatedBarcodeController.currentBottomWidget.value == "ColorContent") {
                  ///   Foreground and Background
                  return Container(
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
                                editCreatedBarcodeController.changeIndexOfGround();
                              },
                              child: Obx(() {
                                return Text(
                                  "Foreground",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: FontFamily.productSansBold,
                                    color: editCreatedBarcodeController.currentGroundIndex.value == 0
                                        ? ColorUtils.activeColor
                                        : ColorUtils.thumbDeActiveColor,
                                  ),
                                );
                              }),
                            ),
                            TextButton(
                              onPressed: () {
                                editCreatedBarcodeController.changeIndexOfGround();
                              },
                              child: Obx(() {
                                return Text(
                                  "Background",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: FontFamily.productSansBold,
                                    color: editCreatedBarcodeController.currentGroundIndex.value == 1
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
                              editCreatedBarcodeController.codeFGBGColor.length,
                              (index) {
                                return InkWell(
                                  onTap: () {
                                    editCreatedBarcodeController.changeIndexOfColor(index);
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: editCreatedBarcodeController.codeFGBGColor[index],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Obx(() {
                                      if (editCreatedBarcodeController.currentGroundIndex.value == 0) {
                                        return editCreatedBarcodeController.currentForeGroundColorIndex.value == index
                                            ? Icon(
                                                Icons.check,
                                                color:
                                                    editCreatedBarcodeController.currentForeGroundColorIndex.value == 1
                                                        ? Colors.black
                                                        : Colors.white,
                                                size: 15,
                                              )
                                            : const SizedBox();
                                      }
                                      return editCreatedBarcodeController.currentBackGroundColorIndex.value == index
                                          ? Icon(
                                              Icons.check,
                                              color: editCreatedBarcodeController.currentBackGroundColorIndex.value == 1
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
                              editCreatedBarcodeController.currentBottomWidget.value = "MainBottomContent";
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
                  );
                }

                ///   Fonts color and text
                return Container(
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
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            TextField(
                              controller: editCreatedBarcodeController.textEditingController,
                              cursorColor: ColorUtils.activeColor,
                              onChanged: (value) {
                                editCreatedBarcodeController.displayText.value = value;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 15, right: 50),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: ColorUtils.activeColor,
                                  ),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                            Align(
                              alignment: const Alignment(0.95, 0),
                              child: IconButton(
                                onPressed: () {
                                  editCreatedBarcodeController.textEditingController.clear();
                                },
                                icon: const Icon(
                                  Icons.close,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            editCreatedBarcodeController.codeFGBGColor.length,
                            (index) {
                              return InkWell(
                                onTap: () {
                                  editCreatedBarcodeController.changeIndexOfColor(index);
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: editCreatedBarcodeController.codeFGBGColor[index],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Obx(() {
                                    if (editCreatedBarcodeController.currentGroundIndex.value == 0) {
                                      return editCreatedBarcodeController.currentForeGroundColorIndex.value == index
                                          ? Icon(
                                              Icons.check,
                                              color: editCreatedBarcodeController.currentForeGroundColorIndex.value == 1
                                                  ? Colors.black
                                                  : Colors.white,
                                              size: 15,
                                            )
                                          : const SizedBox();
                                    }
                                    return editCreatedBarcodeController.currentBackGroundColorIndex.value == index
                                        ? Icon(
                                            Icons.check,
                                            color: editCreatedBarcodeController.currentBackGroundColorIndex.value == 1
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
                            editCreatedBarcodeController.currentBottomWidget.value = "MainBottomContent";
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
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
