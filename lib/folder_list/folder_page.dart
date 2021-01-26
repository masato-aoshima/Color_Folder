import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/folder_item.dart';
import 'package:sort_note/folder_list/folder_model.dart';
import 'package:sort_note/model/models.dart';
import 'package:sort_note/repository/database.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final folderProvider =
    ChangeNotifierProvider((ref) => FolderModel()..getFolders());

class FolderPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final folders = useProvider(folderProvider).folders;
    return Scaffold(
      appBar: AppBar(
        title: Text('フォルダー'),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 150,
        children: List.generate(folders.length, (index) {
          return FolderItem(folders[index].title);
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DBProvider.db.insertFolder(Folder(id: 2, title: '二つ目', priority: 1));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
