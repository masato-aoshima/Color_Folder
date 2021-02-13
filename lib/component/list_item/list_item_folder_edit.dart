import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';
import 'package:sort_note/model/folder.dart';

class ListItemFolderEdit extends StatefulWidget {
  ListItemFolderEdit({this.folder, this.onTapCallback, this.checkedCallback});

  final Folder folder;
  final Function() onTapCallback;
  final Function(bool isCheck) checkedCallback;

  @override
  _ListItemFolderEditState createState() => _ListItemFolderEditState();
}

class _ListItemFolderEditState extends State<ListItemFolderEdit> {
  bool _isCheck = false;

  void _handleCheckbox(bool isCheck) {
    setState(() {
      _isCheck = isCheck;
    });
    widget.checkedCallback(isCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(value: _isCheck, onChanged: _handleCheckbox),
            VerticalDivider(
              color: Colors.grey,
            ),
            Hero(
              tag: 'folderSmallIcon${widget.folder.id}',
              child: FolderSmallIcon(
                size: 45,
                color: widget.folder.color,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.folder.priority.toString(),
            ),
            Text(
              '⋮',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              width: 6,
            ),
            VerticalDivider(
              color: Colors.grey,
            ),
            Icon(
              Icons.dehaze,
              size: 35,
            ),
          ],
        ),
        title: Text(
          widget.folder.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: widget.onTapCallback,
      ),
    );
  }
}
