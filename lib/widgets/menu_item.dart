import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int? count;

  const MenuItem(
      {super.key, required this.icon, required this.title, this.count});

  @override
  Widget build(BuildContext context) {
    TextScaler textScaler = MediaQuery.textScalerOf(context);

    TextStyle trailingStyle = TextStyle(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: textScaler.scale(16),
    );
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(title,
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
      trailing: count != null ? Text('$count', style: trailingStyle) : null,
    );
  }
}
