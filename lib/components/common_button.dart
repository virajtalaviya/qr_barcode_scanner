import 'package:flutter/material.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorUtils.activeColor),
        fixedSize: MaterialStateProperty.all(const Size(150, 40)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
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
