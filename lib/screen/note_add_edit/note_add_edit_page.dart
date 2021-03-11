import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/screen/move_another_folder/move_another_folder_page.dart';
import 'package:sort_note/util/color.dart';

import 'note_add_edit_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final noteAddEditProvider = ChangeNotifierProvider((ref) => NoteAddEditModel());

class NoteAddEditPage extends HookWidget {
  NoteAddEditPage(
      this.note, this.folder, this.isWordCount, this.fontSize, this.fontHeight);

  final Note note;
  final Folder folder;
  final isWordCount;
  final fontSize;
  final fontHeight;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(noteAddEditProvider)
      ..note = note
      ..folder = folder
      ..inputText = note == null ? '' : note.text;
    final myController = TextEditingController(text: provider.inputText);

    SystemChannels.lifecycle.setMessageHandler((msg) {
      if (msg == 'AppLifecycleState.paused') {
        provider.onPause();
      }
      return null;
    });

    return WillPopScope(
      onWillPop: () {
        provider.onPagePop(); // 追加 or 更新 or 削除
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: folder.color,
          titleSpacing: 0,
          iconTheme: IconThemeData(color: getWhiteOrBlack(folder.color)),
          title: Row(children: [
            FolderSmallIcon(
              color: folder.color,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              folder.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getWhiteOrBlack(folder.color)),
            ),
          ]),
          actions: [
            NoteAddEditPagePopupMenu(
              moveCallback: () async {
                if (provider.inputText == null || provider.inputText.isEmpty) {
                  showEmptyTextToast();
                } else {
                  final newNote = Note(
                      id: note == null ? null : note.id,
                      text: provider.inputText,
                      folderId: folder.id);
                  await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MoveAnotherFolderPage(newNote, null),
                              fullscreenDialog: true))
                      .then((value) {
                    if (value != null) {
                      Navigator.pop(context);
                    }
                  });
                }
              },
              deleteCallback: () async {
                // 削除確認ダイアログ表示
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('このノートを削除しますか？'),
                        content: Text('この操作は取り消せません。'),
                        actions: [
                          // ボタン領域
                          FlatButton(
                            child: Text(
                              "キャンセル",
                            ),
                            onPressed: () async => Navigator.pop(context),
                          ),
                          FlatButton(
                            child: Text(
                              "削除",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () async {
                              if (note != null) {
                                await provider.deleteNote(note.id);
                              }
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
            )
          ],
        ),
        body: isWordCount
            ? SafeArea(
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController,
                    onChanged: provider.changeText,
                    maxLines: null,
                    maxLength: TextField.noMaxLength,
                    expands: true,
                    autofocus: note == null,
                    style: TextStyle(fontSize: fontSize, height: fontHeight),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: myController,
                  onChanged: provider.changeText,
                  maxLines: null,
                  expands: true,
                  autofocus: note == null,
                  style: TextStyle(fontSize: fontSize, height: fontHeight),
                ),
              ),
      ),
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
        PopupMenuItem<String>(
          value: "Move",
          child: Row(
            children: [
              Expanded(child: Text('別のフォルダーに移す')),
              FolderSmallIcon(
                size: 25,
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: "Delete",
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'ノートを削除',
                style: TextStyle(color: Colors.red),
              )),
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
