import 'package:flutter/material.dart';
import '../database.dart';

class FolderDashboardPage extends StatefulWidget {
  final String title;
  const FolderDashboardPage({super.key, required this.title});

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
