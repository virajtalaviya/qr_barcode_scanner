import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/utils/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';
import 'package:share_plus/share_plus.dart';

class HistoryController extends GetxController {
  RxBool isSearching = false.obs;
  int currentIndex = 0;

  RxBool showTextField = false.obs;
  TextEditingController historySearchController = TextEditingController();
  RxBool gotScannedData = false.obs;
  RxBool gotCreatedData = false.obs;
  RealmResults<ScannedCode>? realmResultsQRDatabase;
  RealmResults<CreatedCode>? realmResultsCreatedQRCode;

  List<ScannedCode>? realmResultsQRDatabaseToShow;
  List<CreatedCode>? realmResultsCreatedQRCodeToShow;

  List<ScannedCode>? realmResultsQRDatabaseToShowInSearching;
  List<CreatedCode>? realmResultsCreatedQRCodeToShowShowInSearching;

  // List<QRDatabase> scannedCode = [];
  // List<CreatedQRCode> createdCode = [];

  bool checkIfItContainsOrNotInCreated(String text, int i) {
    if (realmResultsCreatedQRCodeToShow?[i].content?.contains(text) ?? false) {
      return true;
    } else if (realmResultsCreatedQRCodeToShow?[i].title?.contains(text) ?? false) {
      return true;
    }
    return false;
  }

  bool checkIfItContainsOrNotInScanned(String text, int i) {
    if (realmResultsQRDatabaseToShow?[i].description?.contains(text) ?? false) {
      return true;
    } else if (realmResultsQRDatabaseToShow?[i].title?.contains(text) ?? false) {
      return true;
    }
    return false;
  }

  void searchProcedure(String textValue) {
    print("-----$textValue");
    if (currentIndex == 0) {
      realmResultsCreatedQRCodeToShowShowInSearching = [];
      for (int i = 0; i < (realmResultsCreatedQRCodeToShow?.length ?? 0); i++) {
        if (checkIfItContainsOrNotInCreated(textValue, i)) {
          realmResultsCreatedQRCodeToShowShowInSearching?.add(
            CreatedCode(
              qrType: realmResultsCreatedQRCodeToShow?[i].qrType,
              bytes: realmResultsCreatedQRCodeToShow?[i].bytes,
              content: realmResultsCreatedQRCodeToShow?[i].content,
              title: realmResultsCreatedQRCodeToShow?[i].title,
            ),
          );
        }
      }
    } else {
      realmResultsQRDatabaseToShow = [];
      for (int i = 0; i < (realmResultsQRDatabaseToShow?.length ?? 0); i++) {
        if (checkIfItContainsOrNotInScanned(textValue, i)) {
          realmResultsQRDatabaseToShowInSearching?.add(
            ScannedCode(
              title: realmResultsQRDatabaseToShow?[i].title,
              description: realmResultsQRDatabaseToShow?[i].description,
              imageType: realmResultsQRDatabaseToShow?[i].imageType,
            ),
          );
        }
      }
    }
    update();
  }

  void deleteScannedQRCode(int index) {
    if (isSearching.value) {
      DataBaseHelper.realm.write(() {
        DataBaseHelper.realm.delete<ScannedCode>(realmResultsQRDatabaseToShowInSearching![index]);
      });
    } else {
      DataBaseHelper.realm.write(() {
        DataBaseHelper.realm.delete<ScannedCode>(realmResultsQRDatabaseToShow![index]);
      });
    }
    getScannedQR();
  }

  void getScannedQR() {
    gotScannedData.value = false;
    realmResultsQRDatabase = DataBaseHelper.realm.all<ScannedCode>();
    realmResultsQRDatabaseToShow = realmResultsQRDatabase?.toList().reversed.toList();
    gotScannedData.value = true;
  }

  void deleteCreatedQRCode(int index) {
    if (isSearching.value) {
      DataBaseHelper.realm.write(() {
        DataBaseHelper.realm.delete<CreatedCode>(realmResultsCreatedQRCodeToShowShowInSearching![index]);
      });
    } else {
      DataBaseHelper.realm.write(() {
        DataBaseHelper.realm.delete<CreatedCode>(realmResultsCreatedQRCodeToShow![index]);
      });
    }

    getCreatedQRCode();
  }

  void getCreatedQRCode() {
    gotCreatedData.value = false;
    realmResultsCreatedQRCode = DataBaseHelper.realm.all<CreatedCode>();
    realmResultsCreatedQRCodeToShow = realmResultsCreatedQRCode?.toList().reversed.toList();
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
