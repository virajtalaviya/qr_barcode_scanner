import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcodeQRController extends GetxController {
  MobileScannerController mobileScannerController = MobileScannerController();
  RxBool isTorchOn = false.obs;
  RxDouble containerWidth = (Get.width * 0.6).obs;
  RxDouble innerContainerWidth = 0.0.obs;

  zoomInZoomOut(String work) {
    if (work == "zoomIn") {
      if (innerContainerWidth.value != 100) {
        innerContainerWidth.value = innerContainerWidth.value + 20.0;
      }
    } else {
      if (innerContainerWidth.value != 0) {
        innerContainerWidth.value = innerContainerWidth.value - 20.0;
      }
    }
    mobileScannerController.setZoomScale(innerContainerWidth.value / 100);
  }

  void torchOnOff() {
    if (isTorchOn.value == true) {
      isTorchOn.value = false;
    } else {
      isTorchOn.value = true;
    }
    mobileScannerController.toggleTorch();
  }
}
