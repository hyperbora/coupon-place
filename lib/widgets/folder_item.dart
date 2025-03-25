import 'package:flutter/material.dart';
import 'package:coupon_place/models/folder.dart' as model;

class FolderItem extends StatelessWidget {
  final ReorderableDragStartListener onDragStart;
  final model.Folder folder;

  const FolderItem(
      {super.key, required this.folder, required this.onDragStart});

  @override
  Widget build(BuildContext context) {
    TextScaler textScaler = MediaQuery.textScalerOf(context);

    TextStyle trailingStyle = TextStyle(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: textScaler.scale(16),
    );
    return ListTile(
      leading: Icon(Icons.folder, color: Theme.of(context).iconTheme.color),
      title: Text(folder.name,
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
      trailing: Text('0', style: trailingStyle),
    );
  }
}
