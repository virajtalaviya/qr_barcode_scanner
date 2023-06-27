import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/components/banner_ad_component.dart';
import 'package:my_scanner/components/common_button.dart';
import 'package:my_scanner/components/common_snackbar.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/database_helper.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SavedBarCode extends StatelessWidget {
  const SavedBarCode({
    Key? key,
    required this.qrImage,
    required this.createdQRCode,
    required this.codeType,
  }) : super(key: key);

  final Uint8List? qrImage;
  final CreatedQRCode createdQRCode;
  final String codeType;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Get.close(3);
        return false;
      },
      child: Scaffold(
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
            "Barcode saved",
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
                Get.close(3);
              },
              icon: Image.asset(
                ImagePaths.homeIcon,
                width: 25,
                height: 25,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: height * 0.5,
                        width: width,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: ColorUtils.splashLogoBG,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorUtils.splashLogoBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              codeType,
                              style: const TextStyle(
                                fontFamily: FontFamily.productSansBold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Center(
                              child: Container(
                                height: height * 0.35,
                                width: width * 0.75,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: qrImage != null
                                      ? DecorationImage(
                                          image: MemoryImage(
                                            qrImage ?? Uint8List(10),
                                          ),
                                        )
                                      : null,
                                  // border: Border.all(color: ColorUtils.splashLogoBorder),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // height: height * 0.15,
                      width: width,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: ColorUtils.splashLogoBG,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorUtils.splashLogoBorder),
                      ),
                      constraints: BoxConstraints(
                        minHeight: height * 0.15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Contents:",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: FontFamily.productSansBold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${createdQRCode.content}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: FontFamily.productSansRegular,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            title: "Share",
                            imagePath: ImagePaths.elevatedButtonShare,
                            onTap: () async {
                              if (qrImage != null) {
                                /// Type of qrImage is Uint8List
                                final Directory temporaryDirectory = await getTemporaryDirectory();
                                final String path = "${temporaryDirectory.path}/image.jpg";
                                File(path).writeAsBytesSync(qrImage!);
                                await Share.shareXFiles([XFile(path)]);
                              } else {
                                showSnackBar(context, "This barcode can't be shared");
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CommonButton(
                            title: "Delete",
                            imagePath: ImagePaths.elevatedButtonDelete,
                            onTap: () {
                              DataBaseHelper.realm.write(() {
                                DataBaseHelper.realm
                                    .delete<CreatedQRCode>(DataBaseHelper.realm.all<CreatedQRCode>().last);
                              });
                              Get.close(3);
                              showSnackBar(context, "Barcode deleted");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: BannerComponent(),
            ),
          ],
        ),
      ),
    );
  }
}
