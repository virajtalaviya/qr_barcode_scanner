import 'package:get/get.dart';
import 'package:my_scanner/screens/scan/scan_barcode_qr.dart';

class HomeController extends GetxController {
  void navigation(int index) {
    switch (index) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        Get.to(() => const ScanBarcodeAndQR());
        break;
    }
  }
}
