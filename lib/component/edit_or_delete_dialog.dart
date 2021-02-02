import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditOrDeleteDialog extends StatelessWidget {
  EditOrDeleteDialog({this.title, this.editFunction, this.deleteFunction});

  final String title;
  final Function editFunction;
  final Function deleteFunction;

  @override
  Widget build(BuildContext context) {
    final dialog = SimpleDialog(
        title: Row(children: [
          Icon(
            Icons.folder_sharp,
            color: Colors.yellow[600],
          ),
          SizedBox(width: 10),
          Text(title)
        ]),
        children: [
          // 編集
          SimpleDialogOption(
            onPressed: () {
              editFunction();
            },
            child: Row(
              children: [Expanded(child: Text('編集')), Icon(Icons.edit_sharp)],
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
