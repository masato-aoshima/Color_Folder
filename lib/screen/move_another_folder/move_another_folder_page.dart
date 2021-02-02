import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/icon/folder_item_widget.dart';

import 'move_another_folder_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final folderProvider =
    ChangeNotifierProvider((ref) => MoveAnotherFolderModel());

class MoveAnotherFolderPage extends HookWidget {
  MoveAnotherFolderPage(this.noteId, this.folderId, this.noteText);

  // TODO メモ追加ページから遷移した場合
  // ノートをnewFolderIdを使って追加する

  // TODO メモ編集ページから遷移した場合
  // noteTextを使ってNoteオブジェクトを作って、アップデートする

  final int noteId;
  final int folderId;
  final String noteText;

  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = useProvider(folderProvider)
      ..noteId = noteId
      ..noteFolderId = folderId
      ..noteText = noteText;

    provider.getFolders();

    return Scaffold(
        appBar: AppBar(
          title: Text('移動先のフォルダーを選択',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: GridView.extent(
            maxCrossAxisExtent: 150,
            children: provider.folders
                .map((folder) => FolderItemWidget(
                      title: folder.title,
                      callback: () async {
                        await await provider.upDateFolderId(folder.id);
                        Navigator.pop(context);
                      },
                      enable: folderId != folder.id,
                    ))
                .toList()));
  }
}
