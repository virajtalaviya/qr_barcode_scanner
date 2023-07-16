class ImagePaths {
  static const String menu = "assets/home/menu.png";
  static const String homeBG = "assets/home/home_bg.png";
  static const String createQR = "assets/home/create_qr.png";
  static const String createBarcode = "assets/home/create_barcode.png";
  static const String scanBarcodeQR = "assets/home/scan_qr_barcode.png";

  /// Drawer
  static const String drawerHome = "assets/home/drawer/home.png";
  static const String drawerHistory = "assets/home/drawer/history.png";
  static const String drawerFeedBack = "assets/home/drawer/feedback.png";
  static const String drawerShareApp = "assets/home/drawer/share_app.png";
  static const String drawerRateUs = "assets/home/drawer/rate_us.png";
  static const String drawerSetting = "assets/home/drawer/settings.png";

  /// history
  static const String qrImage = "assets/history/qr.png";
  static const String barcodeImage = "assets/history/barcode.png";
  static const String share = "assets/history/share.png";
  static const String delete = "assets/history/delete.png";
  static const String searchIcon = "assets/history/search.png";
  static const String closeIcon = "assets/history/close.png";

  static const String backIcon = "assets/back.png";
  static const String homeIcon = "assets/home.png";

  /// text images (QR Type)
  static const String textIcon = "assets/qr_icons/text.png";
  static const String instagramIcon = "assets/qr_icons/instagram.png";
  static const String webIcon = "assets/qr_icons/web.png";
  static const String whatsAppIcon = "assets/qr_icons/whatsapp.png";
  static const String wifiIcon = "assets/qr_icons/wifi.png";

  /// edit created qr
  static const String fontIcon = "assets/edit_created_qr/fonts.png";
  static const String colorIcon = "assets/edit_created_qr/color.png";

  static const String elevatedButtonShare = "assets/share.png";
  static const String elevatedButtonCopy = "assets/copy.png";
  static const String elevatedButtonCheck = "assets/check.png";
  static const String elevatedButtonDelete = "assets/delete_white.png";

  static String qRBarcodeImageInHistory(String? title) {
    if (title == "Product") {
      return barcodeImage;
    } else if (title == "Codabar") {
      return barcodeImage;
    } else if (title == "Code 39 Extended") {
      return barcodeImage;
    } else if (title == "Code 93") {
      return barcodeImage;
    } else if (title == "Code 128") {
      return barcodeImage;
    } else if (title == "Code 128A") {
      return barcodeImage;
    } else if (title == "Code 128B") {
      return barcodeImage;
    } else if (title == "Code 128C") {
      return barcodeImage;
    } else if (title == "EAN-8") {
      return barcodeImage;
    } else if (title == "UPC-A") {
      return barcodeImage;
    } else if (title == "UPC-E") {
      return barcodeImage;
    } else if (title == "EAN-13") {
      return barcodeImage;
    }
    return qrImage;
  }
}
