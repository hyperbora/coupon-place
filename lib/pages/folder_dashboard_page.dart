import 'package:flutter/material.dart';
import '../data/database.dart';

class FolderDashboardPage extends StatefulWidget {
  const FolderDashboardPage({super.key});

  @override
  _FolderDashboardPageState createState() => _FolderDashboardPageState();
}

class _FolderDashboardPageState extends State<FolderDashboardPage> {
  late AppDatabase _db;
  List<Folder> _folders = [];

  @override
  void initState() {
    super.initState();
    _db = AppDatabase();
    _loadFolders();
  }

  Future<void> _loadFolders() async {
    final folders = await _db.getAllFolders();
    setState(() {
      _folders = folders;
    });
  }

  Future<void> _addFolder(Folder folder) async {
    await _db.insertFolder(folder);
    _loadFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _folders.length,
        itemBuilder: (context, index) {
          final folder = _folders[index];
          return ListTile(
            title: Text(folder.name),
          );
        },
      ),
    );
  }
}
