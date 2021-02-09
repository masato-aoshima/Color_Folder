import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';
import 'package:sort_note/util/color.dart';

class ListItemFolder extends StatelessWidget {
  ListItemFolder(
      {this.title,
      this.notesCount = 0,
      this.callback,
      this.longPressCallback,
      this.enable = true,
      this.heroId});

  final String title;
  final int notesCount;
  final Function() callback;
  final Function() longPressCallback;
  final bool enable;
  final String heroId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: 'folderSmallIcon$heroId',
        child: FolderSmallIcon(
          enable: enable,
          size: 45,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            notesCount.toString(),
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.navigate_next),
        ],
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      enabled: enable,
      onTap: callback,
      onLongPress: longPressCallback,
    );
  }
}
