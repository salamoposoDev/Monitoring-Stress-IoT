import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard(
      {super.key,
      required this.title,
      required this.onDelete,
      required this.onTap});
  final String title;
  final Function() onDelete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey.shade900,
      trailing: PopupMenuButton(
        padding: const EdgeInsets.all(0),
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: 'Delete',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delete'),
                  Icon(
                    Icons.delete,
                    size: 20,
                  ),
                ],
              ),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 'Delete') {
            onDelete();
          }
        },
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}
