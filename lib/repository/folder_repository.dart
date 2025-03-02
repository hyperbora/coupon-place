import 'package:coupon_place/data/database.dart' as db;
import 'package:coupon_place/models/folder.dart' as model;

class FolderRepository {
  db.AppDatabase appDatabase;

  FolderRepository({required this.appDatabase});

  Future<void> insertFolder(model.Folder folder) async {
    await appDatabase.insertFolder(db.Folder.fromJson(folder.toMap()));
  }

  Future<List<model.Folder>> getFolders() async {
    final dbFolders = await appDatabase.getAllFolders();
    return dbFolders
        .map((folder) => model.Folder.fromMap(folder.toJson()))
        .toList();
  }
}
