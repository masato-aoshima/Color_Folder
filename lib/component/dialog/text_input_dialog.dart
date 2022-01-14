import 'package:flutter/material.dart';

class TextInputDialog extends StatefulWidget {
  TextInputDialog(this.text);
  final text;

  @override
  State<StatefulWidget> createState() => TextInputDialogState(text);
}

class TextInputDialogState extends State<TextInputDialog> {
  TextInputDialogState(String text) {
    textEditingController = TextEditingController(text: text);
  }

  var textEditingController;

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('キャンセル')),
      TextButton(
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
