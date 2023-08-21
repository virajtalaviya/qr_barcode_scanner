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

  List<QRDatabase> scannedCode = [];
  List<CreatedQRCode> createdCode = [];

  void deleteScannedQRCode(int index) {
    DataBaseHelper.realm.write(() {
      DataBaseHelper.realm.delete<QRDatabase>(realmResultsQRDatabase![index]);
    });
    getScannedQR();
  }

  void getScannedQR() {
    gotScannedData.value = false;
    realmResultsQRDatabase = DataBaseHelper.realm.all<QRDatabase>();
    scannedCode = realmResultsQRDatabase?.toList().reversed.toList() ?? [];
    gotScannedData.value = true;
  }

  void deleteCreatedQRCode(int index) {
    DataBaseHelper.realm.write(() {
      DataBaseHelper.realm.delete<CreatedQRCode>(realmResultsCreatedQRCode![index]);
    });
    getCreatedQRCode();
  }

  void getCreatedQRCode() {
    gotCreatedData.value = false;
    realmResultsCreatedQRCode = DataBaseHelper.realm.all<CreatedQRCode>();
    createdCode = realmResultsCreatedQRCode?.toList().reversed.toList() ?? [];
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
