import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_scanner/controllers/drawer_section_controllers/history_controller.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HistoryAppBar({
    Key? key,
    required this.scaffoldKey,
    required this.historyController,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final HistoryController historyController;

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
      title: Obx(() {
        if (historyController.showTextField.value == true) {
          return TextField(
            controller: historyController.historySearchController,
            cursorColor: ColorUtils.activeColor,
            style: const TextStyle(
              fontFamily: FontFamily.productSansRegular,
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                historyController.isSearching.value = false;
              } else {
                historyController.isSearching.value = true;
                historyController.searchProcedure(value);
              }
            },
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorUtils.activeColor, width: 2),
              ),
              contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 10),
              hintText: "Search",
              hintStyle: TextStyle(
                fontFamily: FontFamily.productSansRegular,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          );
        } else {
          return const Text(
            "History",
            style: TextStyle(
              color: Colors.black,
              fontFamily: FontFamily.productSansBold,
            ),
          );
        }
      }),
      actions: [
        Obx(
          () {
            return historyController.showTextField.value == false
                ? IconButton(
                    onPressed: () {
                      historyController.showTextField.value = !historyController.showTextField.value;
                    },
                    // icon: Image.asset(
                    //   ImagePaths.searchIcon,
                    //   height: 25,
                    //   width: 25,
                    // ),
                    icon: const Icon(
                      Icons.search_sharp,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      historyController.showTextField.value = !historyController.showTextField.value;
                      historyController.isSearching.value = false;
                    },
                    // icon: Image.asset(
                    //   ImagePaths.closeIcon,
                    // ),
                    icon: const Icon(
                      Icons.close,
                    ),
                  );
          },
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
