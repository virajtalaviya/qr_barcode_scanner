import 'package:flutter/material.dart';

class HomeQrBarCodeImage extends StatelessWidget {
  const HomeQrBarCodeImage({
    Key? key,
    required this.imagePath,
    required this.shadowColor,
    required this.gradiantColorList,
  }) : super(key: key);

  final String imagePath;
  final Color shadowColor;
  final List<Color> gradiantColorList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin: const  EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow:  [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: gradiantColorList,
        ),
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          height: 32,
        ),
      ),
    );
  }
}
