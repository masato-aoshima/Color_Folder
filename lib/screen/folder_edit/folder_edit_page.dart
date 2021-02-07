import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/list_item/list_item_folder_edit.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/screen/folder_edit/folder_edit_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final folderProvider = ChangeNotifierProvider((ref) => FolderEditModel());

class FolderEditPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = useProvider(folderProvider)..getFolders();

    return WillPopScope(
      onWillPop: () {
        provider.clearFolder();
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '編集',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
          child: ReorderableListView(
            onReorder: (int oldIndex, int newIndex) {
              provider.onReorder(oldIndex, newIndex);
            },
            children: (provider.folders).map((folder) {
              return Container(
                key: Key(folder.id.toString()),
                child: ListItemFolderEdit(
                  title: folder.title,
                  priority: folder.priority, //TODO 後で消す
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
