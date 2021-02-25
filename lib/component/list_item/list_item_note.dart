import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/util/date.dart';

class ListItemNote extends StatelessWidget {
  ListItemNote(
      {this.note,
      this.dateDisplaySetting,
      this.onTapCallback,
      this.onLongPressCallback});

  final Note note;
  final String dateDisplaySetting;
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
      subtitle: getSubtitle() == null
          ? null
          : Text(
              getSubtitle(),
            ),
      trailing: Icon(Icons.navigate_next),
      onTap: () {
        onTapCallback();
      },
      onLongPress: () {
        onLongPressCallback();
      },
      isThreeLine: false,
    );
  }

  String getSubtitle() {
    String subtitle;
    switch (dateDisplaySetting) {
      case 'NONE':
        break;
      case 'TEXT':
        subtitle = note.text.split("\n").length == 1
            ? '-'
            : note.text
                .split("\n")
                .skip(1)
                .firstWhere((text) => text.isNotEmpty);
        break;
      case 'CREATE_DATE':
        subtitle = '作成日：${getJapaneseDate(note.createdAt)}';
        break;
      case 'UPDATE_DATE':
        subtitle = '変更日：${getJapaneseDate(note.updatedAt)}';
        break;
    }
    return subtitle;
  }
}
