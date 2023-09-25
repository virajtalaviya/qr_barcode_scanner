import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/components/common_button.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/database_helper.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class QrPreviewScreenForCreated extends StatelessWidget {
  const QrPreviewScreenForCreated({
    Key? key,
    required this.createdCode,
    required this.qrImage,
  }) : super(key: key);

  final CreatedCode createdCode;
  final Uint8List qrImage;

  void shareQRImage() async {
    final Directory temporaryDirectory = await getTemporaryDirectory();
    final String path = "${temporaryDirectory.path}/image.jpg";
    File(path).writeAsBytesSync(qrImage);
    await Share.shareXFiles([XFile(path)]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          "Code",
          style: TextStyle(
            color: Colors.black,
            fontFamily: FontFamily.productSansBold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: width,
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
                      const Text(
                        "QR Code",
                        style: TextStyle(
                          fontFamily: FontFamily.productSansBold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Container(
                          height: width * 0.75,
                          width: width * 0.75,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: MemoryImage(qrImage),
                            ),
                          ),
                        ),
                      )
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
                      "${createdCode.content}",
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
                      onTap: () {
                        shareQRImage();
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
                          DataBaseHelper.realm.delete<CreatedCode>(createdCode);
                        });
                        Get.back(result: "getData");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class QrPreviewScreenForScanned extends StatelessWidget {
//   const QrPreviewScreenForScanned({Key? key,required this.qrDatabase}) : super(key: key);
//   final QRDatabase qrDatabase;
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//         title: const Text(
//           "Code",
//           style: TextStyle(
//             color: Colors.black,
//             fontFamily: FontFamily.productSansBold,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
//           child: Column(
//             children: [
//               Center(
//                 child: Container(
//                   height: width,
//                   width: width,
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: ColorUtils.splashLogoBG,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: ColorUtils.splashLogoBorder),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "QR Code",
//                         style: TextStyle(
//                           fontFamily: FontFamily.productSansBold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       Center(
//                         child: Container(
//                           height: width * 0.75,
//                           width: width * 0.75,
//                           padding: const EdgeInsets.all(15),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   borderRadius: BorderRadius.circular(10),
//                           //   image: DecorationImage(
//                           //     image: MemoryImage(qrImage),
//                           //   ),
//                           // ),
//                           child: SfBarcodeGenerator(
//                             value: qrDatabase.description,
//                             symbology: QRCode(),
//                             barColor:
//                             Colors.black,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 // height: height * 0.15,
//                 width: width,
//                 margin: const EdgeInsets.only(top: 10, bottom: 10),
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: ColorUtils.splashLogoBG,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: ColorUtils.splashLogoBorder),
//                 ),
//                 constraints: BoxConstraints(
//                   minHeight: height * 0.15,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Contents:",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontFamily: FontFamily.productSansBold,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       "${createdQRCode.content}",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontFamily: FontFamily.productSansRegular,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CommonButton(
//                       title: "Share",
//                       imagePath: ImagePaths.elevatedButtonShare,
//                       onTap: () {
//                         shareQRImage();
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: CommonButton(
//                       title: "Delete",
//                       imagePath: ImagePaths.elevatedButtonDelete,
//                       onTap: () {
//                         DataBaseHelper.realm.write(() {
//                           DataBaseHelper.realm.delete<CreatedQRCode>(createdQRCode);
//                         });
//                         Get.back(result: "getData");
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
