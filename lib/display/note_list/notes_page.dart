import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/move_or_delete_dialog.dart';
import 'package:sort_note/component/note_item_widget.dart';
import 'package:sort_note/component/text_input_dialog.dart';
import 'package:sort_note/display/move_another_folder/move_another_folder_page.dart';
import 'package:sort_note/display/note_add_edit/note_add_edit_page.dart';
import 'package:sort_note/model/note.dart';

import 'note_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final noteProvider = ChangeNotifierProvider((ref) => NoteModel());

class NotePage extends HookWidget {
  NotePage(this.folderId, this.folderName);

  final String folderName;
  final int folderId;

  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = useProvider(noteProvider)..getNotes(folderId);
    final notes = provider.notes;

    return Scaffold(
      appBar: AppBar(
        title: Text(folderName),
      ),
      body: getListViewWithEmptyMessage(context, notes, provider),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // メモ追加ページに移動
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteAddEditPage(null, null, folderId),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getListViewWithEmptyMessage(
      BuildContext context, List<Note> notes, NoteModel provider) {
    if (notes.length > 0) {
      return ListView(
        children: notes
            .map((note) => NoteItemWidget(
                  text: note.text,
                  onTapCallback: () async {
                    // メモ編集ページに移動
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteAddEditPage(note.id, note.text, folderId),
                        ));
                  },
                  onLongPressCallback: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MoveOrDeleteDialog(
                            noteText: note.text,
                            moveFunction: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MoveAnotherFolderPage(
                                              note.id, note.folderId),
                                      fullscreenDialog: true));
                              Navigator.pop(context);
                            },
                            deleteFunction: () async {
                              await provider.deleteNote(note.id,
                                  note.folderId); //TODO ここで残りが0件だとワーニングが出る
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                ))
            .toList(),
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text('+ ボタンを押して、メモを追加しましょう！',
                  style: TextStyle(fontSize: 100))),
        ),
      );
    }
  }
}

Future<String> showInputTextDialog(BuildContext context, String text) {
  final dialog = TextInputDialog(text);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}
