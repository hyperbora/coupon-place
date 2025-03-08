import 'package:coupon_place/data/database.dart' as db;
import 'package:coupon_place/models/folder.dart' as model;
import 'package:drift/drift.dart';

class FolderRepository {
  db.AppDatabase appDatabase;

  FolderRepository({required this.appDatabase});

  Future<db.Folder> insertFolder(model.Folder folder) async {
    final maxIndex = await appDatabase.getAllFolders().then((folders) {
      return folders.isNotEmpty
          ? folders.map((f) => f.sortIndex).reduce((a, b) => a > b ? a : b)
          : 0;
    });

    final newFolder = folder.copyWith(sortIndex: maxIndex + 1);

    return await appDatabase.into(appDatabase.folders).insertReturning(
          db.FoldersCompanion.insert(
            name: newFolder.name,
            sortIndex: Value(newFolder.sortIndex),
          ),
        );
  }

  Future<List<model.Folder>> getFolders() async {
    final dbFolders = await appDatabase.getAllFolders();
    return dbFolders
        .map((folder) => model.Folder.fromMap(folder.toJson()))
        .toList()
      ..sort((a, b) => a.sortIndex.compareTo(b.sortIndex));
  }

  Stream<List<model.Folder>> watchFolders() {
    return appDatabase.watchAllFolders().map((dbFolders) {
      return dbFolders
          .map((folder) => model.Folder.fromMap(folder.toJson()))
          .toList()
        ..sort((a, b) => a.sortIndex.compareTo(b.sortIndex));
    });
  }

  Future<void> updateFolder(model.Folder folder) async {
    await appDatabase.updateFolder(db.Folder.fromJson(folder.toMap()));
  }

  Future<void> deleteFolder(model.Folder folder) async {
    await appDatabase.deleteFolder(db.Folder.fromJson(folder.toMap()));
  }

  Future<void> updateFolderOrder(List<model.Folder> folders) async {
    await appDatabase.batch((batch) {
      folders.asMap().forEach((index, folder) {
        batch.update(
          appDatabase.folders,
          db.Folder.fromJson(folder.copyWith(sortIndex: index).toMap()),
          where: (tbl) => tbl.id.equals(folder.id),
        );
      });
    });
  }
}
