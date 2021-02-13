import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';
import 'package:sort_note/model/folder.dart';

class ListItemFolder extends StatelessWidget {
  ListItemFolder({
    this.folder,
    this.notesCount = 0,
    this.callback,
    this.longPressCallback,
    this.enable = true,
  });

  final Folder folder;
  final int notesCount;
  final Function() callback;
  final Function() longPressCallback;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: 'folderSmallIcon${folder.id}',
        child: FolderSmallIcon(
          color: folder.color,
          enable: enable,
          size: 45,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            notesCount.toString(),
            style: TextStyle(
                fontSize: 17, color: enable ? Colors.black : Colors.grey),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.navigate_next),
        ],
      ),
      title: Text(
        folder.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      enabled: enable,
      onTap: callback,
      onLongPress: longPressCallback,
    );
  }
}
