import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/dialog/edit_or_delete_dialog.dart';
import 'package:sort_note/component/icon/folder_item_widget.dart';
import 'package:sort_note/component/dialog/text_input_dialog.dart';
import 'package:sort_note/display/folder_list/folder_model.dart';
import 'package:sort_note/display/note_list/notes_page.dart';
import 'package:sort_note/model/folder.dart';

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
        future: provider.getFolders(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return getGridViewWithEmptyMessage(context, snapshot.data, provider);
        },
      ),
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

  Widget getGridViewWithEmptyMessage(
      BuildContext context, List<Folder> folders, FolderModel provider) {
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
                                  final newFolder = Folder(
                                      id: folder.id, title: newFolderName);
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

  Future<String> showInputTextDialog(BuildContext context, String text) {
    final dialog = TextInputDialog(text);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
}
