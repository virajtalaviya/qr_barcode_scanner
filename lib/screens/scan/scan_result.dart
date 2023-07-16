import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:my_scanner/components/common_button.dart';
import 'package:my_scanner/controllers/scan_result_controller.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({Key? key, required this.barcodes}) : super(key: key);
  final BarcodeCapture barcodes;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    ScanResultController scanResultController = Get.put(ScanResultController(barcode: barcodes, context: context));
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
          "Scan Result",
          style: TextStyle(
            color: Colors.black,
            fontFamily: FontFamily.productSansBold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.close(2);
            },
            icon: Image.asset(
              ImagePaths.homeIcon,
              height: 25,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            Container(
                height: 70,
                padding: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  color: ColorUtils.activeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorUtils.scanResultBGColor,
                      child: Image.asset(ImagePaths.textIcon, height: 26),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Text",
                          style: TextStyle(
                            fontFamily: FontFamily.productSansBold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          scanResultController.dateAndTimeFormatter(DateTime.now()),
                          style: const TextStyle(
                            fontFamily: FontFamily.productSansRegular,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            Container(
              height: height * 0.3,
              decoration: BoxDecoration(
                color: ColorUtils.tbBGColor,
                border: Border.all(
                  color: ColorUtils.tbBGBorderColor,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      barcodes.barcodes.length,
                      (index) {
                        return Text(
                          scanResultController.currentContent(index),
                          style: const TextStyle(
                            fontFamily: FontFamily.productSansRegular,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    onTap: () {
                      scanResultController.shareContent();
                    },
                    title: "Share",
                    imagePath: ImagePaths.elevatedButtonShare,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonButton(
                    onTap: () {
                      scanResultController.copyGivenContent(context, true);
                    },
                    title: "Copy",
                    imagePath: ImagePaths.elevatedButtonCopy,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
