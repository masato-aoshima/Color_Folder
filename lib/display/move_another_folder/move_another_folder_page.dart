import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/edit_or_delete_dialog.dart';
import 'package:sort_note/component/folder_item_widget.dart';
import 'package:sort_note/component/text_input_dialog.dart';
import 'package:sort_note/display/folder_list/folder_model.dart';
import 'package:sort_note/display/move_another_folder/move_another_folder_model.dart';
import 'package:sort_note/display/note_list/notes_page.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/repository/database.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final folderProvider =
    ChangeNotifierProvider((ref) => MoveAnotherFolderModel()..getFolders());

class MoveAnotherFolderPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = useProvider(folderProvider);
    final folders = provider.folders;

    final dialog = EditOrDeleteDialog(
      editFunction: (id, title) async {
        final newFolderName = await showInputTextDialog(context, title);
        if (newFolderName != null && newFolderName.isNotEmpty) {
          final folder = Folder(id: id, title: newFolderName);
          provider.upDateFolderName(folder); // TODO priority が 0に戻る
        }
        Navigator.pop(context);
      },
      deleteFunction: (id) {
        provider.deleteFolder(id);
        Navigator.pop(context);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('フォルダー'),
      ),
      body: getGridViewWithEmptyMessage(context, folders, dialog),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String folderName = await showInputTextDialog(context, "");
          if (folderName != null && folderName.isNotEmpty) {
            provider.addFolders(Folder(title: folderName));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<String> showInputTextDialog(BuildContext context, String text) {
    final dialog = TextInputDialog(text);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  Widget getGridViewWithEmptyMessage(
      BuildContext context, List<Folder> folders, EditOrDeleteDialog dialog) {
    if (folders.length > 0) {
      return GridView.extent(
          maxCrossAxisExtent: 150,
          children: folders
              .map((folder) => FolderItemWidget(
                    title: folder.title,
                    callback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NotePage(folder.id, folder.title),
                          ));
                    },
                    longPressCallback: () {
                      EditOrDeleteDialog.show(
                          context, dialog, folder.id, folder.title);
                    },
                  ))
              .toList());
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text('+ ボタンを押して、フォルダーを追加しましょう！',
                  style: TextStyle(fontSize: 100))),
        ),
      );
    }
  }
}
