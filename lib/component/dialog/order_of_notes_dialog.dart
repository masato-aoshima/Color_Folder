import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/repository/shared_preference.dart';

/// ノートの表示順を設定するダイアログ
class OrderOfNotesDialog extends StatelessWidget {
  OrderOfNotesDialog(this.setting, this.selectCallback);
  final String setting;
  final Function selectCallback;

  @override
  Widget build(BuildContext context) {
    print(setting);
    final dialog = SimpleDialog(
      children: [
        SimpleDialogOption(
          child: Row(
            children: [
              Visibility(
                visible: setting == 'text ASC',
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                '本文の昇順',
                style: TextStyle(fontSize: 18),
              )),
            ],
          ),
          onPressed: () {
            selectCallback();
          },
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Opacity(
                opacity: setting == 'text DESC' ? 1 : 0,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                '本文の降順',
                style: TextStyle(fontSize: 18),
              )),
            ],
          ),
          onPressed: () {
            selectCallback();
          },
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Opacity(
                opacity: setting == 'createdAt DESC' ? 1 : 0,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                '作成日の新しい順',
                style: TextStyle(fontSize: 18),
              )),
            ],
          ),
          onPressed: () {
            selectCallback();
          },
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Opacity(
                opacity: setting == 'createdAt ASC' ? 1 : 0,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                '作成日の古い順',
                style: TextStyle(fontSize: 18),
              )),
            ],
          ),
          onPressed: () {
            selectCallback();
          },
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Opacity(
                opacity: setting == 'updatedAt DESC' ? 1 : 0,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                '変更日の新しい順',
                style: TextStyle(fontSize: 18),
              )),
            ],
          ),
          onPressed: () {
            selectCallback();
          },
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Opacity(
                opacity: setting == 'updatedAt ASC' ? 1 : 0,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                '変更日の古い順',
                style: TextStyle(fontSize: 18),
              )),
            ],
          ),
          onPressed: () {
            selectCallback();
          },
        )
      ],
    );
    return dialog;
  }
}

Future showOrderOfNotesDialog(
    BuildContext context, Function selectCallback) async {
  final setting = await getOrderOfNotesSetting();
  await showDialog(
      context: context,
      builder: (_) {
        return OrderOfNotesDialog(setting, selectCallback);
      });
}
