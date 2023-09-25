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
  RealmResults<ScannedCode>? realmResultsQRDatabase;
  RealmResults<CreatedCode>? realmResultsCreatedQRCode;

  // List<QRDatabase> scannedCode = [];
  // List<CreatedQRCode> createdCode = [];

  void deleteScannedQRCode(int index) {
    DataBaseHelper.realm.write(() {
      DataBaseHelper.realm.delete<ScannedCode>(realmResultsQRDatabase![index]);
    });
    getScannedQR();
  }

  void getScannedQR() {
    gotScannedData.value = false;
    realmResultsQRDatabase = DataBaseHelper.realm.all<ScannedCode>();
    // realmResultsQRDatabase = realmResultsQRDatabase?.toList().reversed as RealmResults<QRDatabase>?;
    gotScannedData.value = true;
  }

  void deleteCreatedQRCode(int index) {
    DataBaseHelper.realm.write(() {
      DataBaseHelper.realm.delete<CreatedCode>(realmResultsCreatedQRCode![index]);
    });
    getCreatedQRCode();
  }

  void getCreatedQRCode() {
    gotCreatedData.value = false;
    realmResultsCreatedQRCode = DataBaseHelper.realm.all<CreatedCode>();
    // realmResultsCreatedQRCode = realmResultsCreatedQRCode?.toList().reversed as RealmResults<CreatedQRCode>?;
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
    super.onInit();
    getScannedQR();
    getCreatedQRCode();
  }
}
