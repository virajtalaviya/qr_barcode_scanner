import 'package:flutter/material.dart';
import 'package:my_scanner/controllers/main_bg_controller.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({
    Key? key,
    required this.content,
    required this.mainBGController,
    required this.scaffoldKey,
  }) : super(key: key);
  final List<DrawerElements> content;
  final MainBGController mainBGController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: ColorUtils.drawerContainer,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200, //MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: ColorUtils.drawerContainer,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        color: ColorUtils.splashLogoBG,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorUtils.splashLogoBorder,
                        ),
                      ),
                    ),
                    const SizedBox(height: 27),
                    const Text(
                      "QR -Barcode\nScanner and Generator",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: FontFamily.productSansBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: content.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        mainBGController.drawerTapEvents(index, scaffoldKey);
                      },
                      leading: Image.asset(
                        content[index].icon,
                        height: 25,
                      ),
                      title: Text(
                        content[index].title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.productSansRegular,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}