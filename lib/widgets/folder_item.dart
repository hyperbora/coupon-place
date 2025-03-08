import 'package:coupon_place/pages/navigation_page.dart';
import 'package:flutter/material.dart';

class FolderItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  final EditMode editMode;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ReorderableDragStartListener onDragStart;

  const FolderItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.count,
      required this.editMode,
      required this.onEdit,
      required this.onDelete,
      required this.onDragStart});

  @override
  Widget build(BuildContext context) {
    TextScaler textScaler = MediaQuery.textScalerOf(context);

    TextStyle trailingStyle = TextStyle(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: textScaler.scale(16),
    );
    return ListTile(
      leading: editMode == EditMode.edit
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => (),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(icon, color: Theme.of(context).iconTheme.color),
                ),
              ],
            )
          : Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(title,
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
      trailing: editMode == EditMode.edit
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$count', style: trailingStyle),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: onDragStart,
                )
              ],
            )
          : Text('$count', style: trailingStyle),
    );
  }
}
