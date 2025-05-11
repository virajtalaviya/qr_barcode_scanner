import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/components/banner_ad_component.dart';
import 'package:my_scanner/controllers/main_bg_controller.dart';
import 'package:my_scanner/screens/drawer_screens/home_screen.dart';
import 'package:my_scanner/widgets/custom_app_bars/history_app_bar.dart';
import 'package:my_scanner/widgets/custom_app_bars/home_app_bar.dart';
import 'package:my_scanner/widgets/custom_app_bars/settings_app_bar.dart';
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
          // controller.currentAppBar ??= HomeAppBar(scaffoldKey: scaffoldKey);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Obx(
                () {
                  if(controller.currentBar.value == "home"){
                    return HomeAppBar(scaffoldKey: scaffoldKey);
                  }
                  if(controller.currentBar.value == "history"){
                    return HistoryAppBar(scaffoldKey: scaffoldKey, historyController: controller.historyController);
                  }
                  if(controller.currentBar.value == "settings"){
                    return SettingsAppBar(scaffoldKey: scaffoldKey);
                  }
                  return Container();
                },
              ),
            ),
            drawer: Drawer(
              child: DrawerContent(
                content: controller.drawerContent,
                mainBGController: controller,
                scaffoldKey: scaffoldKey,
              ),
            ),
            body: controller.currentWidget,
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
              child: const BannerComponent(),
            ),
          );
        });
  }
}
