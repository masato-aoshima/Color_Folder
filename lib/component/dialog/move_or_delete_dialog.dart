import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';

class MoveOrDeleteDialog extends StatelessWidget {
  MoveOrDeleteDialog({this.noteText, this.moveFunction, this.deleteFunction});

  final Function moveFunction;
  final Function deleteFunction;
  final String noteText;

  @override
  Widget build(BuildContext context) {
    final dialog =
        SimpleDialog(title: Text(noteText.split("\n").first), children: [
      // 編集
      SimpleDialogOption(
        onPressed: () {
          moveFunction();
        },
        child: Row(
          children: [Expanded(child: Text('別のフォルダーに移動')), FolderSmallIcon()],
        ),
      ),
      // 削除
      SimpleDialogOption(
        onPressed: () {
          deleteFunction();
        },
        child: Row(
          children: [
            Expanded(
                child: Text(
              '削除',
              style: TextStyle(color: Colors.red),
            )),
            Icon(
              Icons.delete_sharp,
              color: Colors.red,
            )
          ],
        ),
      )
    ]);
    return dialog;
  }
}
