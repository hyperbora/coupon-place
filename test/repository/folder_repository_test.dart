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

  test('updateFolder should update a folder in the database', () async {
    final folder = model.Folder.fromMap({"id": '1', "name": "Test Folder"});
    await folderRepository.insertFolder(folder);

    final updatedFolder =
        model.Folder.fromMap({"id": '1', "name": "Updated Folder"});
    await folderRepository.updateFolder(updatedFolder);

    final folders = await folderRepository.getFolders();
    expect(folders.length, 1);
    expect(folders.first.name, 'Updated Folder');
  });

  test('deleteFolder should delete a folder from the database', () async {
    final folder = model.Folder.fromMap({"id": '1', "name": "Test Folder"});
    await folderRepository.insertFolder(folder);

    await folderRepository.deleteFolder(folder);

    final folders = await folderRepository.getFolders();
    expect(folders.length, 0);
  });

  test('updateFolderOrder should update folder sorting order', () async {
    final folder1 = model.Folder.fromMap({"id": '1', "name": "Folder 1"});
    final folder2 = model.Folder.fromMap({"id": '2', "name": "Folder 2"});
    final folder3 = model.Folder.fromMap({"id": '3', "name": "Folder 3"});

    await folderRepository.insertFolder(folder1);
    await folderRepository.insertFolder(folder2);
    await folderRepository.insertFolder(folder3);

    final updatedFolders = [
      model.Folder.fromMap({"id": '3', "name": "Folder 3", "sortIndex": 0}),
      model.Folder.fromMap({"id": '1', "name": "Folder 1", "sortIndex": 1}),
      model.Folder.fromMap({"id": '2', "name": "Folder 2", "sortIndex": 2}),
    ];

    await folderRepository.updateFolderOrder(updatedFolders);

    final folders = await folderRepository.getFolders();
    folders.sort((a, b) => a.sortIndex.compareTo(b.sortIndex));

    expect(folders.length, 3);
    expect(folders[0].id, '3');
    expect(folders[1].id, '1');
    expect(folders[2].id, '2');
  });
}
