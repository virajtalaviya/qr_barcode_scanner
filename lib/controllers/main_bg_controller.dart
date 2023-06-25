import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/controllers/drawer_section_controllers/history_controller.dart';
import 'package:my_scanner/screens/drawer_screens/history.dart';
import 'package:my_scanner/screens/drawer_screens/home_screen.dart';
import 'package:my_scanner/screens/drawer_screens/settings.dart';
import 'package:my_scanner/utils/image_paths.dart';
import 'package:my_scanner/widgets/custom_app_bars/history_app_bar.dart';
import 'package:my_scanner/widgets/custom_app_bars/home_app_bar.dart';
import 'package:my_scanner/widgets/custom_app_bars/settings_app_bar.dart';

class MainBGController extends GetxController {
  Widget? currentWidget;
  PreferredSizeWidget? currentAppBar;
  HistoryController historyController = Get.put(HistoryController());

  List<DrawerElements> drawerContent = [
    DrawerElements(
      icon: ImagePaths.drawerHome,
      title: "Home",
    ),
    DrawerElements(
      icon: ImagePaths.drawerHistory,
      title: "History",
    ),
    DrawerElements(
      icon: ImagePaths.drawerFeedBack,
      title: "Feedback",
    ),
    DrawerElements(
      icon: ImagePaths.drawerShareApp,
      title: "Share app",
    ),
    DrawerElements(
      icon: ImagePaths.drawerRateUs,
      title: "Rate us",
    ),
    DrawerElements(
      icon: ImagePaths.drawerSetting,
      title: "Settings",
    ),
  ];

  void drawerTapEvents(int index, GlobalKey<ScaffoldState> scaffoldKey) {
    Get.back();
    switch (index) {
      case 0:
        currentWidget = const HomeScreen();
        currentAppBar = HomeAppBar(scaffoldKey: scaffoldKey);
        update();
        break;
      case 1:
        currentWidget = History(historyController: historyController);
        currentAppBar = HistoryAppBar(scaffoldKey: scaffoldKey, historyController: historyController);
        update();
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        currentWidget = const Settings();
        currentAppBar = SettingsAppBar(scaffoldKey: scaffoldKey);
        update();
        break;
    }
  }
}

class DrawerElements {
  String icon;
  String title;

  DrawerElements({
    required this.icon,
    required this.title,
  });
}
