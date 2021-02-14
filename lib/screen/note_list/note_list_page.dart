import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/dialog/move_or_delete_dialog.dart';
import 'package:sort_note/component/dialog/text_input_dialog.dart';
import 'package:sort_note/component/list_item/list_item_note.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/screen/move_another_folder/move_another_folder_page.dart';
import 'package:sort_note/screen/note_add_edit/note_add_edit_page.dart';

import 'note_list_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final noteProvider = ChangeNotifierProvider((ref) => NoteListModel());

class NoteListPage extends HookWidget {
  NoteListPage(this.folder);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = useProvider(noteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          folder.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: folder.color,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [NoteListPagePopupMenu()],
      ),
      body: FutureBuilder(
        future: provider.getNotes(folder.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return getListViewWithEmptyMessage(context, snapshot.data, provider);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // メモ追加ページに移動
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteAddEditPage(null, folder),
              )).then((value) {
            provider.getNotesNotify(folder.id);
          });
          ;
        },
        backgroundColor: folder.color,
        child: Icon(Icons.text_snippet_outlined),
      ),
    );
  }

  Widget getListViewWithEmptyMessage(
      BuildContext context, List<Note> notes, NoteListModel provider) {
    if (notes.length > 0) {
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemCount: notes.length,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(color: Colors.grey),
          itemBuilder: (BuildContext context, int index) {
            final note = notes[index];
            return ListItemNote(
              note: note,
              onTapCallback: () async {
                // メモ編集ページに移動
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteAddEditPage(note, folder),
                    )).then((value) {
                  provider.getNotesNotify(folder.id);
                });
              },
              onLongPressCallback: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MoveOrDeleteDialog(
                        folder: folder,
                        noteText: note.text,
                        moveFunction: () async {
                          await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MoveAnotherFolderPage(note),
                                      fullscreenDialog: true))
                              .then((value) {
                            provider.getNotesNotify(folder.id);
                          });
                          Navigator.pop(context);
                        },
                        deleteFunction: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      '${note.text.split("\n").first}を削除しますか？'),
                                  content: Text('この操作は取り消せません。'),
                                  actions: [
                                    // ボタン領域
                                    FlatButton(
                                      child: Text(
                                        "キャンセル",
                                      ),
                                      onPressed: () async =>
                                          Navigator.pop(context),
                                    ),
                                    FlatButton(
                                      child: Text(
                                        "削除",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () async {
                                        await provider.deleteNote(
                                            note.id, folder.id);
                                        Navigator.pop(
                                            context); // TODO ここが0件だとwarningが出ている
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      );
                    });
              },
            );
          },
        ),
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

class NoteListPagePopupMenu extends StatelessWidget {
  NoteListPagePopupMenu({this.sortCallback, this.selectCallback});

  final Function sortCallback;
  final Function selectCallback;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == "SortOrder") {
          sortCallback();
        }
        if (value == "MultiSelect") {
          selectCallback();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: "SortOrder",
          child: Text('並び順を変更'),
        ),
        const PopupMenuItem<String>(
          value: "MultiSelect",
          child: Text('ノートを選択'),
        ),
      ],
    );
  }
}
