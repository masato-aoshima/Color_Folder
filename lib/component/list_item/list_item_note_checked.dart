import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/screen/note_select_list/note_select_list_model.dart';
import 'package:sort_note/util/date.dart';

class ListItemNoteChecked extends StatelessWidget {
  ListItemNoteChecked({this.note, this.provider});

  final Note note;
  final NoteSelectListModel provider;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        note.text.split("\n").first,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
      subtitle: Text('変更日：${getJapaneseDate(note.updatedAt)}'),
      controlAffinity: ListTileControlAffinity.leading,
      value: provider.checkedNoteIds.contains(note.id),
      onChanged: (bool isChecked) {
        provider.onItemCheck(note.id, isChecked);
      },
    );
  }
}
