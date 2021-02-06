import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/dialog/edit_or_delete_dialog.dart';
import 'package:sort_note/component/list_item/list_item_folder.dart';
import 'package:sort_note/component/dialog/text_input_dialog.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/screen/note_list/notes_page.dart';

import 'folder_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final folderProvider = ChangeNotifierProvider((ref) => FolderModel());

class FolderPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = useProvider(folderProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'フォルダー',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([provider.getFolders(), provider.getNotesCount()]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return getListViewWithEmptyMessage(
              context, snapshot.data[0], snapshot.data[1], provider);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String folderName = await showInputTextDialog(context, "");
          if (folderName != null && folderName.isNotEmpty) {
            provider.addFolders(Folder(title: folderName));
          }
        },
        child: Icon(Icons.folder_open_sharp),
      ),
    );
  }

  Widget getListViewWithEmptyMessage(BuildContext context, List<Folder> folders,
      Map<int, int> counts, FolderModel provider) {
    if (folders.length > 0) {
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
            itemCount: folders.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(color: Colors.grey),
            itemBuilder: (BuildContext context, int index) {
              final folder = folders[index];
              return ListItemFolder(
                title: folder.title,
                notesCount: counts[folder.id] ?? 0,
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotePage(folder.id, folder.title),
                      )).then((value) {
                    provider.notifyNotesCount();
                  });
                },
                longPressCallback: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditOrDeleteDialog(
                          title: folder.title,
                          editFunction: () async {
                            final newFolderName = await showInputTextDialog(
                                context, folder.title);
                            if (newFolderName != null &&
                                newFolderName.isNotEmpty) {
                              final newFolder =
                                  Folder(id: folder.id, title: newFolderName);
                              provider.upDateFolderName(
                                  newFolder); // TODO priority が 0に戻る
                            }
                            Navigator.pop(context);
                          },
                          deleteFunction: () {
                            provider.deleteFolder(folder.id);
                            Navigator.pop(context);
                          },
                        );
                      });
                },
              );
            }),
      );
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

  Future<String> showInputTextDialog(BuildContext context, String text) {
    final dialog = TextInputDialog(text);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
}
