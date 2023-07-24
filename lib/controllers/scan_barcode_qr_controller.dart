import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanBarcodeQRController extends GetxController {
  MobileScannerController mobileScannerController = MobileScannerController();
  RxBool isTorchOn = false.obs;
  RxDouble containerWidth = (Get.width * 0.6).obs;
  RxDouble innerContainerWidth = 0.0.obs;
  RxBool hasError = false.obs;
  RxBool gotPermission = false.obs;
  RxBool isLoadinng = true.obs;

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

  Future<bool> didHeGotPermission() async {
    PermissionStatus status = await Permission.camera.status;
    switch (status) {
      case PermissionStatus.denied:
        gotPermission.value = false;
        return false;
      case PermissionStatus.granted:
        gotPermission.value = true;
        return false;
      case PermissionStatus.limited:
        gotPermission.value = true;
        return false;
      case PermissionStatus.permanentlyDenied:
        gotPermission.value = false;
        return false;
      case PermissionStatus.provisional:
        gotPermission.value = false;
        return false;
      case PermissionStatus.restricted:
        gotPermission.value = false;
        return false;
    }
  }

  void getPermission() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (await didHeGotPermission() == false) {
      await Permission.camera.request();
    }
    didHeGotPermission();
    isLoadinng.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getPermission();
  }
}
