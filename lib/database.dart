import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

@DataClassName('Coupon')
class Coupons extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get title => text()();
  TextColumn get description => text()();
  DateTimeColumn get expiryDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Folder')
class Folders extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Coupons, Folders])
class AppDatabase extends _$AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Coupon>> getAllCoupons() => select(coupons).get();
  Stream<List<Coupon>> watchAllCoupons() => select(coupons).watch();
  Future insertCoupon(Coupon coupon) => into(coupons).insert(coupon);
  Future updateCoupon(Coupon coupon) => update(coupons).replace(coupon);
  Future deleteCoupon(Coupon coupon) => delete(coupons).delete(coupon);

  Future<List<Folder>> getAllFolders() => select(folders).get();
  Stream<List<Folder>> watchAllFolders() => select(folders).watch();
  Future insertFolder(Folder folder) => into(folders).insert(folder);
  Future updateFolder(Folder folder) => update(folders).replace(folder);
  Future deleteFolder(Folder folder) => delete(folders).delete(folder);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
