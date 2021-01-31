import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sort_note/display/folder_list/folder_model.dart';
import 'package:sort_note/display/note_add_edit/note_add_edit_model.dart';
import 'package:sort_note/display/note_list/note_model.dart';
import 'package:sort_note/model/note.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final noteAddEditProvider = ChangeNotifierProvider((ref) => NoteAddEditModel());

class NoteAddEditPage extends HookWidget {
  NoteAddEditPage(this.noteId, this.noteText, this.folderId);

  final int noteId;
  final String noteText;
  final int folderId;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(noteAddEditProvider)
      ..noteId = noteId
      ..inputText = noteText
      ..folderId = folderId;
    final myController = TextEditingController(text: provider.inputText);

    return WillPopScope(
      onWillPop: () {
        provider.onPagePop(); // 追加 or 更新 or 削除
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(noteId == null ? "新規メモ" : noteText.split("\n").first),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: myController,
              onChanged: provider.changeText,
              maxLines: null,
              expands: true,
              autofocus: noteId == null,
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }
}
