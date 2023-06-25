import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/controllers/main_bg_controller.dart';
import 'package:my_scanner/screens/drawer_screens/home_screen.dart';
import 'package:my_scanner/widgets/custom_app_bars/home_app_bar.dart';
import 'package:my_scanner/widgets/drawer_content.dart';

class MainBG extends StatelessWidget {
  const MainBG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return GetBuilder<MainBGController>(
        init: MainBGController(),
        builder: (controller) {
          controller.currentWidget ??= const HomeScreen();
          controller.currentAppBar ??= HomeAppBar(scaffoldKey: scaffoldKey);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: controller.currentAppBar,
            drawer: Drawer(
              child: DrawerContent(
                content: controller.drawerContent,
                mainBGController: controller,
                scaffoldKey: scaffoldKey,
              ),
            ),
            body: controller.currentWidget,
          );
        });
  }
}
