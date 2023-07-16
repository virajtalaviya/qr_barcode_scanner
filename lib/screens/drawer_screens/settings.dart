import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/components/common_snackbar.dart';
import 'package:my_scanner/controllers/drawer_section_controllers/settings_controller.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/preference_utils.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.put(SettingsController());
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Auto copy clipboard",
                style: TextStyle(
                  fontFamily: FontFamily.productSansRegular,
                  fontSize: 16,
                ),
              ),
              Obx(() {
                return CupertinoSwitch(
                  value: settingsController.autoCopyToClipBoard.value,
                  onChanged: (value) {
                    settingsController.autoCopyToClipBoard.value = !settingsController.autoCopyToClipBoard.value;
                    PreferenceUtils.setAutoCopyToClipBoardValue(settingsController.autoCopyToClipBoard.value);
                  },
                  activeColor: ColorUtils.activeColor,
                );
              }),
            ],
          ),
          const Divider(
            color: ColorUtils.dividerColor,
            thickness: 1,
          ),
          const SizedBox(height: 25),
          const Text(
            "Scan Control",
            style: TextStyle(
              color: ColorUtils.activeColor,
              fontSize: 16,
              fontFamily: FontFamily.productSansBold,
            ),
          ),
          Obx(() {
            return Row(
              children: [
                Radio(
                  value: "beep",
                  groupValue: settingsController.scanControl.value,
                  onChanged: (value) {
                    settingsController.scanControl.value = "beep";
                    PreferenceUtils.setScanControl("beep");
                  },
                  activeColor: ColorUtils.activeColor,
                ),
                const Text(
                  "Beep",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontFamily.productSansRegular,
                  ),
                ),
                Radio(
                  value: "vibrate",
                  groupValue: settingsController.scanControl.value,
                  onChanged: (value) {
                    settingsController.scanControl.value = "vibrate";
                    PreferenceUtils.setScanControl("vibrate");
                    showSnackBar(context, "Make sure 'Vibrate on touch' is on in settings in your phone",5);
                  },
                  activeColor: ColorUtils.activeColor,
                ),
                const Text(
                  "Vibrate",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontFamily.productSansRegular,
                  ),
                ),
              ],
            );
          }),
          const Divider(
            color: ColorUtils.dividerColor,
            thickness: 1,
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Add Scan history",
                style: TextStyle(
                  fontFamily: FontFamily.productSansRegular,
                  fontSize: 16,
                ),
              ),
              Obx(() {
                return CupertinoSwitch(
                  value: settingsController.addScanHistory.value,
                  onChanged: (value) {
                    settingsController.addScanHistory.value = !settingsController.addScanHistory.value;
                    PreferenceUtils.setAddScanHistoryValue(settingsController.addScanHistory.value);
                  },
                  activeColor: ColorUtils.activeColor,
                );
              }),
            ],
          ),
          const Divider(
            color: ColorUtils.dividerColor,
            thickness: 1,
          ),
          const SizedBox(height: 25),
          // const Text(
          //   "Focus",
          //   style: TextStyle(
          //     color: ColorUtils.activeColor,
          //     fontSize: 16,
          //     fontFamily: FontFamily.productSansBold,
          //   ),
          // ),
          // Obx(() {
          //   return Row(
          //     children: [
          //       Radio(
          //         value: "autoFocus",
          //         groupValue: settingsController.focus.value,
          //         onChanged: (value) {
          //           settingsController.focus.value = "autoFocus";
          //           PreferenceUtils.setFocus("autoFocus");
          //         },
          //         activeColor: ColorUtils.activeColor,
          //       ),
          //       const Text(
          //         "Auto Focus",
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontFamily: FontFamily.productSansRegular,
          //         ),
          //       ),
          //       Radio(
          //         value: "touchFocus",
          //         groupValue: settingsController.focus.value,
          //         onChanged: (value) {
          //           settingsController.focus.value = "touchFocus";
          //           PreferenceUtils.setFocus("touchFocus");
          //         },
          //         activeColor: ColorUtils.activeColor,
          //       ),
          //       const Text(
          //         "Touch Focus",
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontFamily: FontFamily.productSansRegular,
          //         ),
          //       ),
          //     ],
          //   );
          // }),
          // const Divider(
          //   color: ColorUtils.dividerColor,
          //   thickness: 1,
          // ),
        ],
      ),
    );
  }
}
