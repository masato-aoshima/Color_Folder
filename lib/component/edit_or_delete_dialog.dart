import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO 毎回長押しされるたびにダイアログを生成するよう修正
class EditOrDeleteDialog extends StatelessWidget {
  EditOrDeleteDialog({this.editFunction, this.deleteFunction});

  final Function editFunction;
  final Function deleteFunction;
  var folderId;
  var folderTitle;

  @override
  Widget build(BuildContext context) {
    final dialog = SimpleDialog(children: [
      // 編集
      SimpleDialogOption(
        onPressed: () {
          editFunction(folderId, folderTitle);
        },
        child: Row(
          children: [Expanded(child: Text('編集')), Icon(Icons.edit_sharp)],
        ),
      ),
      // 削除
      SimpleDialogOption(
        onPressed: () {
          deleteFunction(folderId);
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

  static void show(BuildContext context, EditOrDeleteDialog dialog,
      int folderId, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog
            ..folderId = folderId
            ..folderTitle = title;
        });
  }
}
