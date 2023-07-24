import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:my_scanner/controllers/scan_barcode_qr_controller.dart';
import 'package:my_scanner/screens/scan/scan_result.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanBarcodeAndQR extends StatelessWidget {
  const ScanBarcodeAndQR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScanBarcodeQRController scanBarcodeQRController = Get.put(ScanBarcodeQRController());
    const double xAxis = 0.6;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Obx(() {
          return scanBarcodeQRController.isLoadinng.value == true
              ? Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      "Scan",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: FontFamily.productSansRegular,
                      ),
                    ),
                  ),
                  body: const Center(child: CircularProgressIndicator()),
                )
              : scanBarcodeQRController.gotPermission.value == false
                  ? Scaffold(
                      appBar: AppBar(
                        title: const Text(
                          "Scan",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: FontFamily.productSansRegular,
                          ),
                        ),
                      ),
                      body: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Please grant permission of camera from settings",
                                style: TextStyle(fontSize: 20, fontFamily: FontFamily.productSansRegular),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        scanBarcodeQRController.isLoadinng.value = true;
                                        scanBarcodeQRController.gotPermission.value = false;
                                        scanBarcodeQRController.getPermission();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(ColorUtils.activeColor),
                                        // fixedSize: MaterialStateProperty.all(const Size(150, 40)),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                      ),
                                      child: Text(
                                        "Retry",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontFamily.productSansRegular,
                                          fontSize: MediaQuery.of(context).size.width * 0.04,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        openAppSettings();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(ColorUtils.activeColor),
                                        // fixedSize: MaterialStateProperty.all(const Size(150, 40)),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                      ),
                                      child: Text(
                                        "Open settings",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontFamily.productSansRegular,
                                          fontSize: MediaQuery.of(context).size.width * 0.04,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Scaffold(
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
                              return scanBarcodeQRController.isTorchOn.value ? const Icon(Icons.flash_on_sharp) : const Icon(Icons.flash_off_sharp);
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
                              onScannerStarted: (arguments) {
                                scanBarcodeQRController.hasError.value = false;
                              },
                              onDetect: (barcodes) {
                                if (scanBarcodeQRController.isTorchOn.value == true) {
                                  scanBarcodeQRController.mobileScannerController.toggleTorch();
                                }
                                Get.to(() => ScanResult(barcodes: barcodes));
                              },
                              errorBuilder: (context, error, child) {
                                scanBarcodeQRController.hasError.value = true;
                                if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
                                  return const AlertDialog(
                                    content: Text(
                                      "Need camera permission to scan,Pleasse grant permission from settings",
                                      style: TextStyle(
                                        fontFamily: FontFamily.productSansRegular,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                if (error.errorCode == MobileScannerErrorCode.genericError) {
                                  return const AlertDialog(
                                    content: Text(
                                      "Some thing went wrong, make sure permission of camera access is enable for this app in settings",
                                      style: TextStyle(
                                        fontFamily: FontFamily.productSansRegular,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return child ?? const SizedBox();
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
                                                width:
                                                    scanBarcodeQRController.containerWidth * scanBarcodeQRController.innerContainerWidth.value / 100,
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
                            Obx(() {
                              return scanBarcodeQRController.hasError.value
                                  ? const SizedBox()
                                  : Align(
                                      alignment: const Alignment(-xAxis, 0.2),
                                      child: Image.asset(
                                        "assets/scan/bottom_left.png",
                                        width: 70,
                                        height: 70,
                                      ),
                                    );
                            }),
                            Obx(() {
                              return scanBarcodeQRController.hasError.value
                                  ? const SizedBox()
                                  : Align(
                                      alignment: const Alignment(xAxis, 0.2),
                                      child: Image.asset(
                                        "assets/scan/bottom_right.png",
                                        width: 70,
                                        height: 70,
                                      ),
                                    );
                            }),
                            Obx(() {
                              return scanBarcodeQRController.hasError.value
                                  ? const SizedBox()
                                  : Align(
                                      alignment: const Alignment(-xAxis, -0.4),
                                      child: Image.asset(
                                        "assets/scan/top_left.png",
                                        width: 70,
                                        height: 70,
                                      ),
                                    );
                            }),
                            Obx(() {
                              return scanBarcodeQRController.hasError.value
                                  ? const SizedBox()
                                  : Align(
                                      alignment: const Alignment(xAxis, -0.4),
                                      child: Image.asset(
                                        "assets/scan/top_right.png",
                                        width: 70,
                                        height: 70,
                                      ),
                                    );
                            }),
                          ],
                        ),
                      ),
                    );
        }),
      ),
    );
  }
}
