import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sort_note/component/list_item/list_item_note_checked.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/screen/move_another_folder/move_another_folder_page.dart';
import 'package:sort_note/screen/note_select_list/note_select_list_model.dart';
import 'package:sort_note/util/color.dart';

final noteProvider = ChangeNotifierProvider((ref) => NoteSelectListModel());

class NoteSelectListPage extends HookConsumerWidget {
  NoteSelectListPage(this.folder, this.dateDisplaySetting);

  final Folder folder;
  final String dateDisplaySetting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(noteProvider);

    // build完了直後に呼び出されるらしい
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getNotes(folder.id);
    });

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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getWhiteOrBlack(folder.color)),
            ),
            backgroundColor: folder.color,
            iconTheme: IconThemeData(color: getWhiteOrBlack(folder.color)),
            centerTitle: true,
            actions: [
              AnimatedOpacity(
                  opacity: provider.checkedNoteIds.length > 0 ? 1 : 0.3,
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      size: 35,
                    ),
                    onPressed: provider.checkedNoteIds.length > 0
                        ? () {
                            showDeleteDialog(context, provider);
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
                      size: 35,
                    ),
                    onPressed: provider.checkedNoteIds.length > 0
                        ? () {
                            // フォルダ移動
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MoveAnotherFolderPage(null,
                                                provider.getCheckedNoteList()),
                                        fullscreenDialog: true))
                                .then((value) {
                              provider.getNotesNotify();
                            });
                          }
                        : null,
                  )),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: getNoteSelectListView(context, provider.notes, provider)),
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
            dateDisplaySetting: dateDisplaySetting,
            provider: provider,
          );
        },
      ),
    );
  }

  void showDeleteDialog(BuildContext context, NoteSelectListModel provider) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('${provider.checkedNoteIds.length}件のノートを削除しますか？'),
            content: Text('この操作は取り消せません。'),
            actions: [
              // ボタン領域
              FlatButton(
                child: Text(
                  "キャンセル",
                ),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text(
                  "削除",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  await provider.deleteCheckedNotes();
                  await provider.getNotesNotify();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
