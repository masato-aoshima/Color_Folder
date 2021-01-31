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

  // TODO Noteオブジェクトをもらった方がいい？
  final int noteId;
  final String noteText;
  final int folderId;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(noteAddEditProvider)
      ..noteId = noteId
      ..inputText = noteText;
    final myController = TextEditingController(text: provider.inputText);

    return WillPopScope(
      onWillPop: () {
        print('画面がポップされます');
        // ここで、更新か追加を行う
        // noteID がからの場合は追加 ただし、テキストが空の場合は何もしない
        // if (noteId == null) {
        //   // 追加
        //   if (provider.inputText.isNotEmpty){
        //     final note = Note(id: null,)
        //   }
        // }

        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(noteId == null ? "新規メモ" : noteText.split("n").first),
          ),
          body: TextFormField(
              controller: myController,
              onChanged: provider.changeText,
              maxLines: null,
              expands: true)),
    );
  }
}
