import 'package:flutter/material.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (scaffoldKey.currentState != null) {
            scaffoldKey.currentState?.openDrawer();
          }
        },
        icon: Image.asset(
          ImagePaths.menu,
          height: 16,
        ),
      ),
      title: const Text(
        "Settings",
        style: TextStyle(
          color: Colors.black,
          fontFamily: FontFamily.productSansBold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
