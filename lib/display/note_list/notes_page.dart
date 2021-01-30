import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/note_item_widget.dart';
import 'package:sort_note/component/text_input_dialog.dart';
import 'package:sort_note/display/note_add_edit/note_add_edit_page.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/repository/database.dart';

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
      body: ListView(
        children: notes
            .map((note) => NoteItemWidget(
                  id: note.id,
                  text: note.text,
                  onTapCallback: (id, text) {
                    // メモ編集ページに移動
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteAddEditPage(id, text, provider),
                        ));
                  },
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // メモ追加ページに移動
        },
        child: Icon(Icons.add),
      ),
    );
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
