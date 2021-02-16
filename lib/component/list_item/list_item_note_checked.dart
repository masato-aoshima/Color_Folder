import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/util/date.dart';

class ListItemNoteChecked extends StatefulWidget {
  ListItemNoteChecked({this.note, this.onChecked});

  final Note note;
  final Function(bool) onChecked;

  @override
  _ListItemNoteCheckedState createState() => _ListItemNoteCheckedState();
}

class _ListItemNoteCheckedState extends State<ListItemNoteChecked> {
  bool _isCheck = false;

  void _handleCheckbox(bool isCheck) {
    setState(() {
      _isCheck = isCheck;
    });
    widget.onChecked(isCheck);
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.note.text.split("\n").first,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
      subtitle: Text('変更日：${getJapaneseDate(widget.note.updatedAt)}'),
      controlAffinity: ListTileControlAffinity.leading,
      value: _isCheck,
      onChanged: (bool value) {
        _handleCheckbox(value);
      },
    );
  }
}
