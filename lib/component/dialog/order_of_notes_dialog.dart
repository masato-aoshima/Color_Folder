import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ノートの表示順を設定するダイアログ
class OrderOfNotesDialog extends StatelessWidget {
  // TODO 現在の設定値にマークする

  @override
  Widget build(BuildContext context) {
    final dialog = SimpleDialog(
      title: Text('ノートの並び順'),
      children: [
        SimpleDialogOption(
          child: Text('テキスト昇順'),
        )
      ],
    );
    return dialog;
  }
}
