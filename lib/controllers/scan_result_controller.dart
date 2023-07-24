import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:my_scanner/components/audio_player_helper.dart';
import 'package:my_scanner/utils/database_helper.dart';
import 'package:my_scanner/utils/preference_utils.dart';
import 'package:share_plus/share_plus.dart';

class ScanResultController extends GetxController {
  ScanResultController({required this.barcode, required this.context}) {
    if (PreferenceUtils.getAddScanHistoryValue(true)) {
      for (int i = 0; i < barcode.barcodes.length; i++) {
        DataBaseHelper.realm.write(() {
          DataBaseHelper.realm.add(
            QRDatabase(
              imageType: barcode.image == null ? "text" : "image",
              title: getBarcodeType(i),
              description: currentContent(i),
            ),
          );
        });
      }
    }
    if (PreferenceUtils.getAutoCopyToClipBoardValue(false)) {
      copyGivenContent(context, false);
    }
    if (PreferenceUtils.getScanControl("vibrate") == "vibrate") {
      HapticFeedback.vibrate();
    } else {
      AudioHelper.playAudio();
    }
  }

  NativeAd? nativeAd;

  void loadNativeAD() {
    nativeAd = NativeAd(
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      listener: NativeAdListener(
        onAdImpression: (ad) {},
        onAdClicked: (ad) {},
        onAdFailedToLoad: (ad, error) {},
        onAdClosed: (ad) {},
        onAdLoaded: (ad) {},
        onAdOpened: (ad) {},
        onAdWillDismissScreen: (ad) {},
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
      ),
    );
    nativeAd?.load();
  }

  BarcodeCapture barcode;
  BuildContext context;

  String getBarcodeType(int index) {
    switch (barcode.barcodes[index].type) {
      case BarcodeType.url:
        return "URL";
      case BarcodeType.contactInfo:
        return "Contact Info";
      case BarcodeType.email:
        return "Email";
      case BarcodeType.isbn:
        return "ISBNs";
      case BarcodeType.phone:
        return "Phone";
      case BarcodeType.product:
        return "Product";
      case BarcodeType.sms:
        return "SMS";
      case BarcodeType.text:
        return "Text";
      case BarcodeType.wifi:
        return "Wi-Fi";
      case BarcodeType.geo:
        return "Geographic coordinates";
      case BarcodeType.calendarEvent:
        return "Calendar event";
      case BarcodeType.driverLicense:
        return "Driving license";
      case BarcodeType.unknown:
        return "Nothing to show";
    }
  }

  String currentContent(int index) {
    switch (barcode.barcodes[index].type) {
      case BarcodeType.url:
        return "${barcode.barcodes[index].url?.title ?? ""}\n${barcode.barcodes[index].url?.url ?? ""}";
      case BarcodeType.contactInfo:
        return contactInfo(barcode.barcodes[index].contactInfo);
      case BarcodeType.email:
        return giveEmail(barcode.barcodes[index].email);
      case BarcodeType.isbn:
        return "${barcode.barcodes[index].rawValue}";
      case BarcodeType.phone:
        return givePhone(barcode.barcodes[index].phone);
      case BarcodeType.product:
        return barcode.barcodes[index].rawValue ?? "";
      case BarcodeType.sms:
        return giveSMS(barcode.barcodes[index].sms);
      case BarcodeType.text:
        return barcode.barcodes[index].displayValue ?? "n/a";
      case BarcodeType.wifi:
        return giveWifi(barcode.barcodes[index].wifi);
      case BarcodeType.geo:
        return geography(barcode.barcodes[index].geoPoint);
      case BarcodeType.calendarEvent:
        return calendarEvent(barcode.barcodes[index].calendarEvent);
      case BarcodeType.driverLicense:
        return giveDrivingLicenseData(barcode.barcodes[index].driverLicense);
      case BarcodeType.unknown:
        return "${barcode.barcodes[index].rawValue}";
    }
  }

  String contactInfo(ContactInfo? contactInfo) {
    String name = "";
    String phone = "";

    name =
        "Name : ${contactInfo?.name?.prefix ?? ""} ${contactInfo?.name?.first ?? ""} ${contactInfo?.name?.middle ?? ""} ${contactInfo?.name?.last ?? ""} ${contactInfo?.name?.suffix ?? ""}\n";

    if (contactInfo?.phones?.isNotEmpty ?? false) {
      phone = "Phone : ${contactInfo?.phones?[0].number ?? ""}";
    }

    return "$name\n$phone";
  }

  String giveEmail(Email? email) {
    String type = "";
    switch (email?.type ?? EmailType.unknown) {
      case EmailType.work:
        type = "Email type : Work";
        break;
      case EmailType.unknown:
        type = "Email type : Unknown";
        break;
      case EmailType.home:
        type = "Email type : Home";
        break;
    }
    String body = email?.body ?? "";
    String address = email?.address ?? "";
    String subject = email?.subject ?? "";
    return "$type\n$address\n$subject\n$body";
  }

  String givePhone(Phone? phone) {
    String phoneType = "";
    switch (phone?.type ?? PhoneType.unknown) {
      case PhoneType.home:
        phoneType = "Phone number type : Home";
        break;
      case PhoneType.work:
        phoneType = "Phone number type : Work";
        break;
      case PhoneType.fax:
        phoneType = "Phone number type : Fax";
        break;
      case PhoneType.mobile:
        phoneType = "Phone number type : Mobile";
        break;
      case PhoneType.unknown:
        phoneType = "Phone number type : Unknown";
        break;
    }
    String phoneNumber = "Phone number : ${phone?.number ?? "n/a"}";
    return "$phoneType\n$phoneNumber";
  }

  String giveSMS(SMS? sms) {
    String phoneNumber = sms?.phoneNumber ?? "";
    String message = sms?.message ?? "n/a";
    return "$phoneNumber\n$message";
  }

  String giveWifi(WiFi? wifi) {
    String type = "";
    switch (wifi?.encryptionType ?? EncryptionType.none) {
      case EncryptionType.open:
        type = "Encryption type : Open";
        break;
      case EncryptionType.wep:
        type = "Encryption type : WEP";
        break;
      case EncryptionType.wpa:
        type = "Encryption type : WPA";
        break;
      case EncryptionType.none:
        type = "Encryption type : None";
        break;
    }
    return "$type\n${wifi?.password ?? ""}";
  }

  String geography(GeoPoint? geoPoint) {
    String lat = "";
    String long = "";
    lat = "Latitude : ${geoPoint?.latitude ?? "n/a"}";
    long = "Longitude : ${geoPoint?.longitude ?? "n/a"}";
    return "$lat\n$long";
  }

  String calendarEvent(CalendarEvent? calendarEvent) {
    String eventStart = "";
    String eventEnd = "";
    String eventStatus = "";
    String description = "";
    String location = "";
    String organizer = "";
    String summary = "";

    eventStart = "Start : ${dateAndTimeFormatter(calendarEvent?.start)}";
    eventEnd = "End : ${dateAndTimeFormatter(calendarEvent?.end)}";
    eventStatus = "Status : ${calendarEvent?.status ?? "n/a"}";
    description = "Description : ${calendarEvent?.description ?? "n/a"}";
    location = "Location : ${calendarEvent?.location ?? "n/a"}";
    organizer = "Organizer = ${calendarEvent?.organizer ?? "n/a"}";
    summary = "Summary = ${calendarEvent?.summary ?? "n/a"}";
    return "$eventStart\n$eventEnd\n$eventStatus\n$description\n$location\n$organizer\n$summary";
  }

  String giveDrivingLicenseData(DriverLicense? driverLicense) {
    String addressStreet = driverLicense?.addressStreet ?? "";
    String addressCity = driverLicense?.addressCity ?? "";
    String addressState = driverLicense?.addressState ?? "";
    String addressZip = driverLicense?.addressZip ?? "";

    String fullAddress = "Address : $addressStreet, $addressCity, $addressState, $addressZip";

    String firstName = "First name : ${driverLicense?.firstName ?? ""}";
    String middleName = "Middle name : ${driverLicense?.middleName ?? ""}";
    String lastName = "Last name : ${driverLicense?.lastName ?? ""}";

    String birthDate = "Birth date : ${driverLicense?.birthDate ?? " "}";
    String documentType = "Document type : ${driverLicense?.documentType ?? " "}";
    String expiryDate = "Expiry date : ${driverLicense?.expiryDate ?? " "}";
    String gender = "Gender : ${driverLicense?.gender ?? " "}";
    String issueDate = "Issue date : ${driverLicense?.issueDate ?? " "}";
    String issuingCountry = "Issuing country : ${driverLicense?.issuingCountry ?? " "}";
    String licenseNumber = "License number : ${driverLicense?.licenseNumber ?? " "}";

    return "$firstName\n$middleName\n$lastName\n$fullAddress\n$birthDate\n$documentType\n$expiryDate\n$gender\n$issueDate\n$issuingCountry\n$licenseNumber";
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
    }
    return "December";
  }

  String giveTime(DateTime dateTime) {
    String hour;
    String minutes;
    String amPm;

    hour = "${dateTime.hour}";
    minutes = "${dateTime.minute}";

    if (dateTime.hour > 12) {
      hour = "${dateTime.hour - 12}";
      amPm = "PM";
    } else {
      if (dateTime.hour == 12) {
        amPm = "PM";
      } else {
        amPm = "AM";
      }
    }
    return "$hour : $minutes $amPm";
  }

  String dateAndTimeFormatter(DateTime? dateTime) {
    if (dateTime != null) {
      String day = "${dateTime.day}";
      String month = getMonth(dateTime.month);
      String year = "${dateTime.year}";
      String time = giveTime(dateTime);
      return "$day $month $year $time";
    }
    return "n/a";
  }

  void shareContent() {
    String content = "";

    for (int i = 0; i < barcode.barcodes.length; i++) {
      content = content + currentContent(i);
    }
    Share.share(content);
  }

  void copyGivenContent(BuildContext context, bool showSnackBar) async {
    String content = "";

    for (int i = 0; i < barcode.barcodes.length; i++) {
      content = content + currentContent(i);
    }
    await Clipboard.setData(ClipboardData(text: content));
    if (showSnackBar) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Text copied successfully"),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10),
          ),
        );
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadNativeAD();
  }
}
