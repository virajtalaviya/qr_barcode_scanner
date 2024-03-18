import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_scanner/components/common_button.dart';
import 'package:my_scanner/controllers/create_qr/create_qr_controller.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';

class CreateQRScreen extends StatelessWidget {
  const CreateQRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateQRController createQRController = Get.put(CreateQRController());
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            ImagePaths.backIcon,
            height: 25,
          ),
        ),
        title: const Text(
          "Create QR Code",
          style: TextStyle(
            color: Colors.black,
            fontFamily: FontFamily.productSansBold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                // width: 250,
                // height: 60,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                decoration: BoxDecoration(
                  color: ColorUtils.tbBGColor,
                  border: Border.all(color: ColorUtils.tbBGBorderColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: DropdownButtonFormField(
                  value: "Text",
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  dropdownColor: ColorUtils.autoCopyThumbSurfaceColor,
                  isExpanded: true,
                  isDense: false,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: FontFamily.productSansRegular,
                    fontSize: 16,
                  ),
                  items: createQRController.createQRDropDownContent.map((value) {
                    return DropdownMenuItem(
                      value: value.value,
                      onTap: () {
                        createQRController.currentValue.value = value.value;
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                value.imagePath,
                                height: 25,
                                width: 25,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            value.value,
                            style: const TextStyle(
                              color: ColorUtils.dropDownTextColor,
                              fontFamily: FontFamily.productSansRegular,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              ),
              Container(
                height: height * 0.3,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: ColorUtils.tbBGColor,
                  border: Border.all(color: ColorUtils.tbBGBorderColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        createQRController.currentValue.value,
                        style: const TextStyle(
                          fontFamily: FontFamily.productSansBold,
                          fontSize: 16,
                        ),
                      );
                    }),
                    Expanded(
                      child: TextField(
                        controller: createQRController.textEditingController,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        style: const TextStyle(fontFamily: FontFamily.productSansRegular),
                        cursorColor: ColorUtils.activeColor,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 40,
                child: CommonButton(
                  title: "Create",
                  imagePath: ImagePaths.elevatedButtonCheck,
                  onTap: () {
                    createQRController.tapEventOfCreateButton(context);
                  },
                ),
              ),
              Obx(() {
                print("[][][][][][][]${createQRController.nativeAdLoaded.value}");
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 270,//MediaQuery.of(context).size.height * 0.25,
                  child: createQRController.nativeAdLoaded.value
                      ? AdWidget(ad: createQRController.nativeAd)
                      : const SizedBox(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
