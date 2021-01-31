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
  MoveAnotherFolderPage(this.noteId, this.folderId);

  final int noteId;
  final int folderId;

  @override
  Widget build(BuildContext context) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = useProvider(folderProvider)
      ..noteId = noteId
      ..noteFolderId = folderId;
    final folders = provider.folders;

    return Scaffold(
        appBar: AppBar(
          title: Text('移動先のフォルダーを選択'),
        ),
        body: GridView.extent(
            maxCrossAxisExtent: 150,
            children: folders
                .map((folder) => FolderItemWidget(
                      title: folder.title,
                      callback: () async {
                        await provider.upDateFolderId(folder.id);
                        Navigator.pop(context);
                      },
                    ))
                .toList()));
  }
}
