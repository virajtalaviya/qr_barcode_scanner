import 'package:realm/realm.dart';

part 'database_helper.g.dart';

@RealmModel()
class _ScannedCode {
  String? imageType;
  String? title;
  String? description;
}


@RealmModel()
class _CreatedCode{
  String? title;
  String? content;
  String? qrType;
  String? bytes;
}

class DataBaseHelper {
  static Configuration config = Configuration.local([ScannedCode.schema,CreatedCode.schema]);
  static late Realm realm;

  static void initDatabase() {
    realm = Realm(config);
  }
}
