import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';

void showLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        content: Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: SpinKitFadingCircle(
                color: ColorUtils.activeColor,
                size: 30,
              ),
            ),
            SizedBox(width: 20),
            Text(
              "Please wait...",
              style: TextStyle(
                fontFamily: FontFamily.productSansRegular,
              ),
            ),
          ],
        ),
      );
    },
  );
}
