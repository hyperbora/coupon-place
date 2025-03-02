import 'package:flutter_test/flutter_test.dart';
import 'package:coupon_place/repository/folder_repository.dart';
import 'package:coupon_place/data/database.dart';
import 'package:coupon_place/models/folder.dart' as model;

void main() {
  late FolderRepository folderRepository;
  late AppDatabase appDatabase;

  setUp(() async {
    appDatabase = AppDatabase(mode: DatabaseMode.memory);
    folderRepository = FolderRepository(appDatabase: appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  test('insertFolder should insert a folder into the database', () async {
    final folder = model.Folder.fromMap({"id": '1', "name": "Test Folder"});
    await folderRepository.insertFolder(folder);

    final folders = await folderRepository.getFolders();
    expect(folders.length, 1);
    expect(folders.first.name, 'Test Folder');
  });

  test('getFolders should return all folders from the database', () async {
    final folder1 = model.Folder.fromMap({"id": '1', "name": "Test Folder 1"});
    final folder2 = model.Folder.fromMap({"id": '2', "name": "Test Folder 2"});
    await folderRepository.insertFolder(folder1);
    await folderRepository.insertFolder(folder2);

    final folders = await folderRepository.getFolders();
    expect(folders.length, 2);
    expect(folders[0].name, 'Test Folder 1');
    expect(folders[1].name, 'Test Folder 2');
  });
}
