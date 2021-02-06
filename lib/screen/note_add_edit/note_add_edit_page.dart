import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';
import 'package:sort_note/screen/move_another_folder/move_another_folder_page.dart';

import 'note_add_edit_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final noteAddEditProvider = ChangeNotifierProvider((ref) => NoteAddEditModel());

class NoteAddEditPage extends HookWidget {
  NoteAddEditPage(this.noteId, this.noteText, this.folderId, this.folderName);

  final int noteId;
  final String noteText;
  final int folderId;
  final String folderName;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(noteAddEditProvider)
      ..noteId = noteId
      ..inputText = noteText
      ..folderId = folderId;
    final myController = TextEditingController(text: provider.inputText);

    return WillPopScope(
      onWillPop: () {
        provider.onPagePop(); // 追加 or 更新 or 削除
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(children: [
              FolderSmallIcon(),
              SizedBox(
                width: 6,
              ),
              Text(
                folderName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ]),
            iconTheme: IconThemeData(color: Colors.black),
            actions: [
              NoteAddEditPagePopupMenu(
                moveCallback: () async {
                  if (provider.inputText == null ||
                      provider.inputText.isEmpty) {
                    showEmptyTextToast();
                  } else {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoveAnotherFolderPage(
                                noteId, folderId, provider.inputText),
                            fullscreenDialog: true));
                    Navigator.pop(context);
                  }
                },
                deleteCallback: () async {
                  if (noteId != null) {
                    await provider.deleteNote(noteId);
                  }
                  Navigator.pop(context); // TODO ここではonWillPopは呼ばれない　らしい(調べる)
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: myController,
              onChanged: provider.changeText,
              maxLines: null,
              expands: true,
              autofocus: noteId == null,
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }

  void showEmptyTextToast() {
    Fluttertoast.showToast(
        msg: "テキストがありません",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

class NoteAddEditPagePopupMenu extends StatelessWidget {
  NoteAddEditPagePopupMenu({this.moveCallback, this.deleteCallback});

  final Function moveCallback;
  final Function deleteCallback;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == "Move") {
          moveCallback();
        }
        if (value == "Delete") {
          deleteCallback();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: "Move",
          child: Text('別のフォルダーに移す'),
        ),
        const PopupMenuItem<String>(
          value: "Delete",
          child: Text('削除'),
        ),
      ],
    );
  }
}