import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/model/note.dart';

class ListItemNote extends StatelessWidget {
  ListItemNote({this.note, this.onTapCallback, this.onLongPressCallback});

  final Note note;
  final Function() onTapCallback;
  final Function() onLongPressCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        note.text.split("\n").first,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
      subtitle: Text('変更日：${note.updatedAt}'),
      trailing: Icon(Icons.navigate_next),
      onTap: () {
        onTapCallback();
      },
      onLongPress: () {
        onLongPressCallback();
      },
    );
  }
}
