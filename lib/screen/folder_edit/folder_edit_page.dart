import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/list_item/list_item_folder.dart';
import 'package:sort_note/screen/folder_edit/folder_edit_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final folderProvider = ChangeNotifierProvider((ref) => FolderEditModel());

class FolderEditPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = useProvider(folderProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '編集',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([provider.getFolders(), provider.getNotesCount()]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
                itemCount: snapshot.data[0].length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: Colors.grey),
                itemBuilder: (BuildContext context, int index) {
                  final folder = (snapshot.data[0])[index];
                  return ListItemFolder(
                    title: folder.title,
                    notesCount: (snapshot.data[1])[folder.id] ?? 0,
                  );
                }),
          );
        },
      ),
    );
  }
}
