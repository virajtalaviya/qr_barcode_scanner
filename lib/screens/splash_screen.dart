import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_scanner/controllers/splash_controller.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: ColorUtils.splashLogoBG,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorUtils.splashLogoBorder),
                          image: const DecorationImage(image: AssetImage("assets/logo_qr_scanner.png")),
                        ),
                      ),
                      const SizedBox(height: 27),
                      const Text(
                        " QR - Barcode Generator\n and scanner",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.productSansBold,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 0.95),
                  // child: Icon(Icons.access_alarm_rounded),
                  child: SizedBox(
                    height: 50,
                    child: SpinKitWave(
                      size: 25,
                      duration: const Duration(seconds: 1),
                      itemBuilder: (BuildContext context, int index) {
                        return const DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.blue, //index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
