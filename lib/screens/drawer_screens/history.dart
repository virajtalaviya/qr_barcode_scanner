import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_scanner/controllers/drawer_section_controllers/history_controller.dart';
import 'package:my_scanner/screens/qr_preview_screen.dart';
import 'package:my_scanner/utils/color_utils.dart';
import 'package:my_scanner/utils/font_family.dart';
import 'package:my_scanner/utils/image_paths.dart';
import 'package:share_plus/share_plus.dart';

class History extends StatefulWidget {
  const History({Key? key, required this.historyController}) : super(key: key);
  final HistoryController historyController;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            width: 250,
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            decoration: BoxDecoration(
              color: ColorUtils.tbBGColor,
              border: Border.all(color: ColorUtils.tbBGBorderColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TabBar(
              controller: tabController,
              automaticIndicatorColorAdjustment: false,
              enableFeedback: true,
              labelColor: Colors.white,
              tabs: const [
                Tab(
                  child: Text(
                    "Created",
                    style: TextStyle(
                      fontFamily: FontFamily.productSansBold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Scanned",
                    style: TextStyle(
                      fontFamily: FontFamily.productSansBold,
                    ),
                  ),
                ),
              ],
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: const TextStyle(
                fontFamily: FontFamily.productSansBold,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: ColorUtils.activeColor,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                HistoryPageCreated(
                  historyController: widget.historyController,
                ),
                HistoryPageScanned(
                  historyController: widget.historyController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryPageCreated extends StatelessWidget {
  const HistoryPageCreated({Key? key, required this.historyController}) : super(key: key);
  final HistoryController historyController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return historyController.gotCreatedData.value == false
          ? const Center(child: CircularProgressIndicator())
          : historyController.createdCode.isEmpty
              ? const Center(
                  child: Text(
                    "No created code found!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: FontFamily.productSansRegular,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: historyController.createdCode.length,
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: ColorUtils.autoCopyThumbSurfaceColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorUtils.tbBGBorderColor,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          List<int> imageBytes = historyController.createdCode[index].bytes?.split(',').map(int.parse).toList() ?? [];
                          Uint8List qrImageData = Uint8List.fromList(imageBytes);
                          final result = await Get.to(
                            () => QrPreviewScreenForCreated(
                              createdQRCode: historyController.createdCode[index],
                              qrImage: qrImageData,
                            ),
                          );
                          if (result == "getData") {
                            historyController.getCreatedQRCode();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 10),
                                Image.asset(
                                  ImagePaths.qRBarcodeImageInHistory(
                                    historyController.createdCode[index].title,
                                  ),
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      historyController.createdCode[index].title ?? "",
                                      style: const TextStyle(
                                        fontFamily: FontFamily.productSansBold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: Text(
                                        historyController.createdCode[index].content ?? "",
                                        style: const TextStyle(
                                          fontFamily: FontFamily.productSansRegular,
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            PopupMenuButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    onTap: () {
                                      historyController.shareQRImage(
                                        historyController.createdCode[index].bytes ?? "",
                                      );
                                    },
                                    padding: const EdgeInsets.only(left: 10, right: 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          ImagePaths.share,
                                          width: 25,
                                          height: 25,
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          "Share",
                                          style: TextStyle(
                                            fontFamily: FontFamily.productSansRegular,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      historyController.deleteCreatedQRCode(index);
                                    },
                                    padding: const EdgeInsets.only(left: 10, right: 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          ImagePaths.delete,
                                          width: 25,
                                          height: 25,
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          "Delete",
                                          style: TextStyle(
                                            fontFamily: FontFamily.productSansRegular,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
    });
  }
}

class HistoryPageScanned extends StatelessWidget {
  const HistoryPageScanned({Key? key, required this.historyController}) : super(key: key);

  final HistoryController historyController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return historyController.gotScannedData.value == false
          ? const Center(child: CircularProgressIndicator())
          : historyController.scannedCode.isEmpty
              ? const Center(
                  child: Text(
                    "No scanned code found!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: FontFamily.productSansRegular,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: historyController.scannedCode.length,
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: ColorUtils.autoCopyThumbSurfaceColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorUtils.tbBGBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 10),
                              Image.asset(
                                ImagePaths.qRBarcodeImageInHistory(
                                  historyController.scannedCode[index].title,
                                ),
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    historyController.scannedCode[index].title ?? "",
                                    style: const TextStyle(
                                      fontFamily: FontFamily.productSansBold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      (historyController.scannedCode[index].description ?? "").trim(),
                                      style: const TextStyle(
                                        fontFamily: FontFamily.productSansRegular,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          PopupMenuButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  onTap: () {
                                    Share.share((historyController.scannedCode[index].description ?? "").trim());
                                  },
                                  padding: const EdgeInsets.only(left: 10, right: 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        ImagePaths.share,
                                        width: 25,
                                        height: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Share",
                                        style: TextStyle(
                                          fontFamily: FontFamily.productSansRegular,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    String content = (historyController.scannedCode[index].description ?? "").trim();
                                    await Clipboard.setData(ClipboardData(text: content));
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Text copied successfully"),
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(10),
                                        ),
                                      );
                                    }
                                  },
                                  padding: const EdgeInsets.only(left: 10, right: 15),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Image.asset(
                                      //   ImagePaths.delete,
                                      //   width: 25,
                                      //   height: 25,
                                      // ),
                                      Icon(Icons.copy),
                                      SizedBox(width: 10),
                                      Text(
                                        "Copy",
                                        style: TextStyle(
                                          fontFamily: FontFamily.productSansRegular,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    historyController.deleteScannedQRCode(index);
                                  },
                                  padding: const EdgeInsets.only(left: 10, right: 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        ImagePaths.delete,
                                        width: 25,
                                        height: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontFamily: FontFamily.productSansRegular,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ];
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
    });
  }
}
