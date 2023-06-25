import 'package:flutter/material.dart';
import 'package:my_scanner/components/home_qr_barcode_image.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';

class CommonBox extends StatelessWidget {
  const CommonBox({
    Key? key,
    required this.path,
    required this.content,
    required this.shadowColor,
    required this.gradiantColorList,
    required this.tapEvents,
  }) : super(key: key);

  final String path;
  final String content;
  final Color shadowColor;
  final List<Color> gradiantColorList;
  final VoidCallback tapEvents;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: tapEvents,
        child: AspectRatio(
          aspectRatio: 1.3,
          child: Container(
            decoration: BoxDecoration(
              color: ColorUtils.splashLogoBG,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ColorUtils.splashLogoBorder,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HomeQrBarCodeImage(
                  imagePath: path,
                  shadowColor: shadowColor,
                  gradiantColorList: gradiantColorList,
                ),
                const SizedBox(height: 10),
                Text(
                  content,
                  style: const TextStyle(
                    fontFamily: FontFamily.productSansBold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
