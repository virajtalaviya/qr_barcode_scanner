import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/components/common_box_in_home.dart';
import 'package:my_scanner/components/home_qr_barcode_image.dart';
import 'package:my_scanner/controllers/drawer_section_controllers/home_screen_controller.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    HomeController homeController = Get.put(HomeController());
    return SingleChildScrollView(
     
      child: Padding(
      
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Container(
              height: height * 0.5,
              decoration: const BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
                  image: AssetImage(
                    ImagePaths.homeBG,
                  ),
                ),
              ),
            ),
            Row(
              
              children: [
                CommonBox(
                  path: ImagePaths.createQR,
                  content: "Create QR",
                  shadowColor: ColorUtils.createQrShadow,
                  gradiantColorList: ColorUtils.createQrGradient,
                  tapEvents: () {
                    homeController.screenCount = 0;
                    if (homeController.interstitialAd != null) {
                      homeController.interstitialAd?.show();
                    } else {
                      homeController.navigation();
                    }
                  },
                ),
                const SizedBox(width: 10),
                CommonBox(
                  path: ImagePaths.createBarcode,
                  content: "Create Barcode",
                  shadowColor: ColorUtils.createBarCodeShadow,
                  gradiantColorList: ColorUtils.createBarCodeGradient,
                  tapEvents: () {
                    homeController.screenCount = 1;
                    if (homeController.interstitialAd != null) {
                      homeController.interstitialAd?.show();
                    } else {
                      homeController.navigation();
                    }
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                homeController.screenCount = 2;
                if (homeController.interstitialAd != null) {
                  homeController.interstitialAd?.show();
                } else {
                  homeController.navigation();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorUtils.splashLogoBG,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorUtils.splashLogoBorder,
                  ),
                ),
                child: const Row(
                  children: [
                    HomeQrBarCodeImage(
                      imagePath: ImagePaths.scanBarcodeQR,
                      shadowColor: ColorUtils.scanBarcodeQrShadow,
                      gradiantColorList: ColorUtils.scanBarcodeQrGradient,
                    ),
                    Text(
                      "Scan Barcode and QR",
                      style: TextStyle(
                        fontFamily: FontFamily.productSansBold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
