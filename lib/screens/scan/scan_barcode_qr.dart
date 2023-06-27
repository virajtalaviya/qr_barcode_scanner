import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:my_scanner/controllers/scan_barcode_qr_controller.dart';
import 'package:my_scanner/screens/scan/scan_result.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';

class ScanBarcodeAndQR extends StatelessWidget {
  const ScanBarcodeAndQR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScanBarcodeQRController scanBarcodeQRController = Get.put(ScanBarcodeQRController());
    const double xAxis = 0.6;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Scan",
              style: TextStyle(
                fontSize: 20,
                fontFamily: FontFamily.productSansRegular,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  scanBarcodeQRController.torchOnOff();
                },
                icon: Obx(() {
                  return scanBarcodeQRController.isTorchOn.value
                      ? const Icon(Icons.flash_on_sharp)
                      : const Icon(Icons.flash_off_sharp);
                }),
              ),
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              gradient: LinearGradient(
                colors: [
                  Color(0xff4A4545),
                  Color(0xffFFFFFF),
                  Color(0xffFFFFFF),
                  Color(0xff4A4545),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                MobileScanner(
                  controller: scanBarcodeQRController.mobileScannerController,
                  onDetect: (barcodes) {
                    Get.to(() => ScanResult(barcodes: barcodes));
                  },
                ),
                Align(
                  alignment: const Alignment(0, 0.65),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            scanBarcodeQRController.zoomInZoomOut("zoomOut");
                          },
                          icon: const Icon(
                            Icons.zoom_out,
                            color: Colors.white,
                          ),
                        ),
                        Obx(
                          () {
                            return Container(
                              height: 5,
                              width: scanBarcodeQRController.containerWidth.value,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 5,
                                    width: scanBarcodeQRController.containerWidth *
                                        scanBarcodeQRController.innerContainerWidth.value /
                                        100,
                                    decoration: BoxDecoration(
                                      color: ColorUtils.activeColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            scanBarcodeQRController.zoomInZoomOut("zoomIn");
                          },
                          icon: const Icon(
                            Icons.zoom_in,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-xAxis, 0.2),
                  child: Image.asset(
                    "assets/scan/bottom_left.png",
                    width: 70,
                    height: 70,
                  ),
                ),
                Align(
                  alignment: const Alignment(xAxis, 0.2),
                  child: Image.asset(
                    "assets/scan/bottom_right.png",
                    width: 70,
                    height: 70,
                  ),
                ),
                Align(
                  alignment: const Alignment(-xAxis, -0.4),
                  child: Image.asset(
                    "assets/scan/top_left.png",
                    width: 70,
                    height: 70,
                  ),
                ),
                Align(
                  alignment: const Alignment(xAxis, -0.4),
                  child: Image.asset(
                    "assets/scan/top_right.png",
                    width: 70,
                    height: 70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
