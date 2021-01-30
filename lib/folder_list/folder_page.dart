import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/edit_or_delete_dialog.dart';
import 'package:sort_note/component/folder_item_widget.dart';
import 'package:sort_note/component/text_input_dialog.dart';
import 'package:sort_note/folder_list/folder_model.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/note_list/notes_page.dart';
import 'package:sort_note/repository/database.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final folderProvider =
    ChangeNotifierProvider((ref) => FolderModel()..getFolders());

class FolderPage extends HookWidget {
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
      body: GridView.extent(
          maxCrossAxisExtent: 150,
          children: folders
              .map((folder) => FolderItemWidget(
                    id: folder.id,
                    title: folder.title,
                    callback: (id, title) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotePage(id, title),
                          ));
                    },
                    longPressCallback: (id, title) {
                      EditOrDeleteDialog.show(context, dialog, id, title);
                    },
                  ))
              .toList()),
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
}
