import 'package:flutter/material.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    this.width,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final VoidCallback onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(ColorUtils.activeColor),
        fixedSize: WidgetStateProperty.all(Size(width ?? 150, 40)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 25,
            width: 25,
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: FontFamily.productSansRegular,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
