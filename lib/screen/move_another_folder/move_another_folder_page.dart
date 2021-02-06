import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/list_item/list_item_folder.dart';

import 'move_another_folder_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final folderProvider =
    ChangeNotifierProvider((ref) => MoveAnotherFolderModel());

class MoveAnotherFolderPage extends HookWidget {
  MoveAnotherFolderPage(this.noteId, this.folderId, this.noteText);

  final int noteId;
  final int folderId;
  final String noteText;

  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = useProvider(folderProvider)
      ..noteId = noteId
      ..noteText = noteText;

    provider.getFolders();
    provider.getNotesCount();

    return Scaffold(
        appBar: AppBar(
          title: Text('移動先のフォルダーを選択',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.separated(
              itemCount: provider.folders.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(color: Colors.grey),
              itemBuilder: (BuildContext context, int index) {
                final folder = provider.folders[index];
                final count = provider.noteCounts[folder.id];
                return ListItemFolder(
                  title: folder.title,
                  notesCount: count ?? 0,
                  callback: () async {
                    await provider.onTapFolder(folder.id);
                    Navigator.pop(context);
                  },
                  enable: folderId != folder.id,
                );
              }),
        ));
  }
}
