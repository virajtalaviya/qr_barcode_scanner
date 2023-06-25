import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/utils/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';
import 'package:share_plus/share_plus.dart';

class HistoryController extends GetxController {
  RxBool showTextField = false.obs;
  TextEditingController historySearchController = TextEditingController();
  RxBool gotScannedData = false.obs;
  RxBool gotCreatedData = false.obs;
  RealmResults<QRDatabase>? realmResultsQRDatabase;
  RealmResults<CreatedQRCode>? realmResultsCreatedQRCode;

  void getScannedQR() {
    gotScannedData.value = false;
    realmResultsQRDatabase = DataBaseHelper.realm.all<QRDatabase>();
    gotScannedData.value = true;
  }

  // void showDeletedQrCode() {
  //   Get.dialog(
  //     AlertDialog(
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             Icons.delete,
  //             color: ColorUtils.activeColor,
  //           ),
  //           Text(
  //             "Are you sure, you want to delete this code",
  //             style: TextStyle(
  //               fontFamily: FontFamily.productSansRegular,
  //               fontSize: 16,
  //             ),
  //           ),
  //           Row(
  //             children: [
  //
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void deleteQRCodeData(int index) {
    DataBaseHelper.realm.write(() {
      DataBaseHelper.realm.delete<CreatedQRCode>(realmResultsCreatedQRCode![index]);
    });
    getCreatedQRCode();
  }

  void getCreatedQRCode() {
    gotCreatedData.value = false;
    realmResultsCreatedQRCode = DataBaseHelper.realm.all<CreatedQRCode>();
    gotCreatedData.value = true;
  }

  void shareQRImage(String data) async {

    List<int> memoryData = data.split(',').map(int.parse).toList();

    final Directory temporaryDirectory = await getTemporaryDirectory();

    final String path = "${temporaryDirectory.path}/image.jpg";

    File(path).writeAsBytesSync(memoryData);

    await Share.shareXFiles([XFile(path)]);

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getScannedQR();
    getCreatedQRCode();
  }
}
