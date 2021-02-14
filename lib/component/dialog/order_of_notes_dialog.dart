import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ノートの表示順を設定するダイアログ
class OrderOfNotesDialog extends StatelessWidget {
  // TODO 現在の設定値にマークする

  @override
  Widget build(BuildContext context) {
    final dialog = SimpleDialog(
      children: [
        SimpleDialogOption(
          child: Row(
            children: [
              Visibility(
                visible: true,
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
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Visibility(
                visible: true,
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
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Visibility(
                visible: true,
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
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Visibility(
                visible: true,
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
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Visibility(
                visible: true,
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
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Visibility(
                visible: true,
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
        )
      ],
    );
    return dialog;
  }
}
