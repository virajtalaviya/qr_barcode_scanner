import 'package:get/get.dart';
import 'package:my_scanner/utils/preference_utils.dart';

class SettingsController extends GetConnect {
  RxBool autoCopyToClipBoard = true.obs;
  RxString scanControl = "beep".obs;
  RxBool addScanHistory = true.obs;
  RxString focus = "autoFocus".obs;

  void setValuesFromPreference() {
    autoCopyToClipBoard.value = PreferenceUtils.getAutoCopyToClipBoardValue(false);
    scanControl.value = PreferenceUtils.getScanControl("beep");
    addScanHistory.value = PreferenceUtils.getAddScanHistoryValue(true);
    focus.value = PreferenceUtils.getFocus("autoFocus");
  }

  @override
  void onInit() {
    setValuesFromPreference();
  }
}
