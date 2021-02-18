import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/list_item/list_item_note_checked.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/screen/move_another_folder/move_another_folder_page.dart';
import 'package:sort_note/screen/note_select_list/note_select_list_model.dart';

final noteProvider = ChangeNotifierProvider((ref) => NoteSelectListModel());

class NoteSelectListPage extends HookWidget {
  NoteSelectListPage(this.folder);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(noteProvider);

    return WillPopScope(
      onWillPop: () {
        provider.clear();
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'ノート選択',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: folder.color,
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            actions: [
              AnimatedOpacity(
                  opacity: provider.checkedNoteIds.length > 0 ? 1 : 0.3,
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: provider.checkedNoteIds.length > 0
                        ? () {
                            // 削除
                            print('削除アイコンをタップ');
                          }
                        : null,
                  )),
              SizedBox(
                width: 10,
              ),
              AnimatedOpacity(
                  opacity: provider.checkedNoteIds.length > 0 ? 1 : 0.3,
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    icon: Icon(
                      Icons.folder_open_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: provider.checkedNoteIds.length > 0
                        ? () {
                            // フォルダ移動
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MoveAnotherFolderPage(
                                        null, provider.getCheckedNoteList()),
                                    fullscreenDialog: true));
                          }
                        : null,
                  )),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: provider.notes.length == 0
              ? FutureBuilder(
                  future: provider.getNotes(folder.id),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return getNoteSelectListView(
                        context, snapshot.data, provider);
                  },
                )
              : getNoteSelectListView(context, provider.notes, provider)),
    );
  }

  Widget getNoteSelectListView(
      BuildContext context, List<Note> notes, NoteSelectListModel provider) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        itemCount: notes.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.grey),
        itemBuilder: (BuildContext context, int index) {
          final note = notes[index];
          return ListItemNoteChecked(
            note: note,
            onChecked: (isChecked) {
              provider.onItemCheck(note.id, isChecked);
            },
          );
        },
      ),
    );
  }
}
