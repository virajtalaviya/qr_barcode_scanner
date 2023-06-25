// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_helper.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class QRDatabase extends _QRDatabase
    with RealmEntity, RealmObjectBase, RealmObject {
  QRDatabase({
    String? imageType,
    String? title,
    String? description,
  }) {
    RealmObjectBase.set(this, 'imageType', imageType);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
  }

  QRDatabase._();

  @override
  String? get imageType =>
      RealmObjectBase.get<String>(this, 'imageType') as String?;
  @override
  set imageType(String? value) => RealmObjectBase.set(this, 'imageType', value);

  @override
  String? get title => RealmObjectBase.get<String>(this, 'title') as String?;
  @override
  set title(String? value) => RealmObjectBase.set(this, 'title', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  Stream<RealmObjectChanges<QRDatabase>> get changes =>
      RealmObjectBase.getChanges<QRDatabase>(this);

  @override
  QRDatabase freeze() => RealmObjectBase.freezeObject<QRDatabase>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(QRDatabase._);
    return const SchemaObject(
        ObjectType.realmObject, QRDatabase, 'QRDatabase', [
      SchemaProperty('imageType', RealmPropertyType.string, optional: true),
      SchemaProperty('title', RealmPropertyType.string, optional: true),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
    ]);
  }
}

class CreatedQRCode extends _CreatedQRCode
    with RealmEntity, RealmObjectBase, RealmObject {
  CreatedQRCode({
    String? title,
    String? content,
    String? qrType,
    String? bytes,
  }) {
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'content', content);
    RealmObjectBase.set(this, 'qrType', qrType);
    RealmObjectBase.set(this, 'bytes', bytes);
  }

  CreatedQRCode._();

  @override
  String? get title => RealmObjectBase.get<String>(this, 'title') as String?;
  @override
  set title(String? value) => RealmObjectBase.set(this, 'title', value);

  @override
  String? get content =>
      RealmObjectBase.get<String>(this, 'content') as String?;
  @override
  set content(String? value) => RealmObjectBase.set(this, 'content', value);

  @override
  String? get qrType => RealmObjectBase.get<String>(this, 'qrType') as String?;
  @override
  set qrType(String? value) => RealmObjectBase.set(this, 'qrType', value);

  @override
  String? get bytes => RealmObjectBase.get<String>(this, 'bytes') as String?;
  @override
  set bytes(String? value) => RealmObjectBase.set(this, 'bytes', value);

  @override
  Stream<RealmObjectChanges<CreatedQRCode>> get changes =>
      RealmObjectBase.getChanges<CreatedQRCode>(this);

  @override
  CreatedQRCode freeze() => RealmObjectBase.freezeObject<CreatedQRCode>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CreatedQRCode._);
    return const SchemaObject(
        ObjectType.realmObject, CreatedQRCode, 'CreatedQRCode', [
      SchemaProperty('title', RealmPropertyType.string, optional: true),
      SchemaProperty('content', RealmPropertyType.string, optional: true),
      SchemaProperty('qrType', RealmPropertyType.string, optional: true),
      SchemaProperty('bytes', RealmPropertyType.string, optional: true),
    ]);
  }
}
