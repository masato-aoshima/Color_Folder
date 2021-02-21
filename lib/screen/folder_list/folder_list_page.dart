import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/list_item/list_item_folder.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/repository/shared_preference.dart';
import 'package:sort_note/screen/folder_detail/folder_detail_page.dart';
import 'package:sort_note/screen/folder_edit_list/folder_edit_list_page.dart';
import 'package:sort_note/screen/note_list/note_list_page.dart';
import 'package:sort_note/screen/settings/settings_page.dart';
import 'package:sort_note/util/color.dart';

import 'folder_list_model.dart';

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
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: getWhiteOrBlackByThemeColor(context)),
        ),
        iconTheme: IconThemeData(color: getWhiteOrBlackByThemeColor(context)),
        leading: IconButton(
          iconSize: 26,
          icon: Icon(
            Icons.settings,
            color: getWhiteOrBlackByThemeColor(context),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                    fullscreenDialog: true));
          },
        ),
        actions: [
          Row(
            children: [
              Center(
                  child: TextButton(
                onPressed: () {
                  if (provider.folders.length > 0) {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FolderEditPage(),
                                fullscreenDialog: true))
                        .then((value) {
                      provider.notifyNotesCount();
                    });
                  } else {
                    showEmptyFolderToast();
                  }
                },
                child: Text(
                  '編集',
                  style: TextStyle(
                      color: getWhiteOrBlackByThemeColor(context),
                      fontSize: 18),
                ),
              )),
              SizedBox(
                width: 10,
              )
            ],
          )
        ],
      ),
      body: FutureBuilder(
        future: Future.wait([provider.getFolders(), provider.getNotesCount()]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return getListViewWithEmptyMessage(
              context, snapshot.data[0], snapshot.data[1], provider);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final folderColorString = await getFolderDefaultColor();
          final folderColor = rawStringToColor(folderColorString);
          await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FolderDetailPage(defaultColor: folderColor),
                      fullscreenDialog: true))
              .then((value) {
            provider.getFoldersNotify();
          });
        },
        child: Icon(
          Icons.folder_open_sharp,
          color: getWhiteOrBlackByThemeColor(context),
        ),
      ),
    );
  }

  Widget getListViewWithEmptyMessage(BuildContext context, List<Folder> folders,
      Map<int, int> counts, FolderModel provider) {
    if (folders.length > 0) {
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
            itemCount: folders.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(color: Colors.grey),
            itemBuilder: (BuildContext context, int index) {
              final folder = folders[index];
              return ListItemFolder(
                folder: folder,
                notesCount: counts[folder.id] ?? 0,
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteListPage(folder),
                      )).then((value) {
                    provider.notifyNotesCount();
                  });
                },
                longPressCallback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FolderDetailPage(
                          folder: folder,
                        ),
                      )).then((value) {
                    provider.getFoldersNotify();
                  });
                },
              );
            }),
      );
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

  void showEmptyFolderToast() {
    Fluttertoast.showToast(
        msg: "フォルダーがありません",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
