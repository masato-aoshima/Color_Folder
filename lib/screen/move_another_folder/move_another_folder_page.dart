import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/list_item/list_item_folder.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';

import 'move_another_folder_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final folderProvider =
    ChangeNotifierProvider((ref) => MoveAnotherFolderModel());

class MoveAnotherFolderPage extends HookWidget {
  MoveAnotherFolderPage(this.note);

  final Note note;

  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = useProvider(folderProvider)..note = note;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('移動先のフォルダーを選択', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder(
        future: Future.wait([provider.getFolders(), provider.getNotesCount()]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final folders = snapshot.data[0];
          final noteCounts = snapshot.data[1];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
                itemCount: folders.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: Colors.grey),
                itemBuilder: (BuildContext context, int index) {
                  final folder = folders[index];
                  final count = noteCounts[folder.id];
                  return ListItemFolder(
                    folder: folder,
                    notesCount: count ?? 0,
                    callback: () async {
                      await provider.onTapFolder(folder.id);
                      Navigator.pop(context);
                    },
                    enable: note.folderId != folder.id,
                  );
                }),
          );
        },
      ),
    );
  }
}
