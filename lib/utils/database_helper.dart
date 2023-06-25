import 'package:realm/realm.dart';

part 'database_helper.g.dart';

@RealmModel()
class _QRDatabase {
  String? imageType;
  String? title;
  String? description;
}


@RealmModel()
class _CreatedQRCode{
  String? title;
  String? content;
  String? qrType;
  String? bytes;
}

class DataBaseHelper {
  static Configuration config = Configuration.local([QRDatabase.schema,CreatedQRCode.schema]);
  static late Realm realm;

  static void initDatabase() {
    realm = Realm(config);
  }
}
