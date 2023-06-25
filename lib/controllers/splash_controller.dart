import 'package:get/get.dart';
import 'package:my_scanner/components/audio_player_helper.dart';
import 'package:my_scanner/screens/main_bg.dart';
import 'package:my_scanner/utils/database_helper.dart';
import 'package:my_scanner/utils/preference_utils.dart';

class SplashController extends GetxController {
  void doSplashAdministration() {
    PreferenceUtils.initPreference();
    DataBaseHelper.initDatabase();
    AudioHelper.loadAsset();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Get.off(() => const MainBG());
      },
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    doSplashAdministration();
  }
}
