import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TextInputDialogState();
}

class TextInputDialogState extends State<TextInputDialog> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = [
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('キャンセル')),
      FlatButton(
          onPressed: () {
            String inputText = textEditingController.text.toString();
            Navigator.pop(context, inputText);
          },
          child: Text('OK'))
    ];

    final AlertDialog dialog = AlertDialog(
      title: Text('フォルダ名を入力'),
      content: TextField(
        controller: textEditingController,
        decoration: InputDecoration(hintText: '新規フォルダ'),
        autofocus: true,
      ),
      actions: actions,
    );

    return dialog;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
