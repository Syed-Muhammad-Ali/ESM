import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreOptionsPopupMenu extends StatelessWidget {
  const MoreOptionsPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'block':
            Get.snackbar("Blocked", "User has been blocked.");
            break;
          case 'report':
            Get.snackbar("Reported", "User has been reported.");
            break;
          case 'clear':
            Get.snackbar("Cleared", "Chat cleared.");
            break;
        }
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'block',
              child: Row(
                children: [
                  Icon(Icons.block),
                  SizedBox(width: 10),
                  Text('Block'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'report',
              child: Row(
                children: [
                  Icon(Icons.report),
                  SizedBox(width: 10),
                  Text('Report'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'clear',
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 10),
                  Text('Clear Chat'),
                ],
              ),
            ),
          ],
      icon: Icon(Icons.more_vert),
    );
  }
}
