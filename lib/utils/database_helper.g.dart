// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_helper.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ScannedCode extends _ScannedCode
    with RealmEntity, RealmObjectBase, RealmObject {
  ScannedCode({
    String? imageType,
    String? title,
    String? description,
  }) {
    RealmObjectBase.set(this, 'imageType', imageType);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
  }

  ScannedCode._();

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
  Stream<RealmObjectChanges<ScannedCode>> get changes =>
      RealmObjectBase.getChanges<ScannedCode>(this);

  @override
  ScannedCode freeze() => RealmObjectBase.freezeObject<ScannedCode>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ScannedCode._);
    return const SchemaObject(
        ObjectType.realmObject, ScannedCode, 'QRDatabase', [
      SchemaProperty('imageType', RealmPropertyType.string, optional: true),
      SchemaProperty('title', RealmPropertyType.string, optional: true),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
    ]);
  }
}

class CreatedCode extends _CreatedCode
    with RealmEntity, RealmObjectBase, RealmObject {
  CreatedCode({
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

  CreatedCode._();

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
  Stream<RealmObjectChanges<CreatedCode>> get changes =>
      RealmObjectBase.getChanges<CreatedCode>(this);

  @override
  CreatedCode freeze() => RealmObjectBase.freezeObject<CreatedCode>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CreatedCode._);
    return const SchemaObject(
        ObjectType.realmObject, CreatedCode, 'CreatedQRCode', [
      SchemaProperty('title', RealmPropertyType.string, optional: true),
      SchemaProperty('content', RealmPropertyType.string, optional: true),
      SchemaProperty('qrType', RealmPropertyType.string, optional: true),
      SchemaProperty('bytes', RealmPropertyType.string, optional: true),
    ]);
  }
}
