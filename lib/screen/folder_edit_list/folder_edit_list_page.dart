import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sort_note/component/list_item/list_item_folder_edit.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/screen/folder_detail/folder_detail_page.dart';
import 'package:sort_note/util/color.dart';

import 'folder_edit_list_model.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final folderProvider = ChangeNotifierProvider((ref) => FolderEditModel());

class FolderEditPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 4. 観察する変数を useProvider を使って宣言
    final provider = ref.watch(folderProvider);

    // build完了直後に呼び出されるらしい
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getFolders();
    });

    return WillPopScope(
      onWillPop: () {
        provider.clear();
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '編集',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getWhiteOrBlackByThemeColor(context)),
          ),
          iconTheme: IconThemeData(color: getWhiteOrBlackByThemeColor(context)),
          actions: [
            AnimatedOpacity(
              opacity: provider.checkedFolderIds.length > 0 ? 1 : 0.3,
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    size: 30,
                    color: getWhiteOrBlackByThemeColor(context),
                  ),
                  onPressed: provider.checkedFolderIds.length > 0
                      ? () async {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text(
                                      '${provider.checkedFolderIds.length}件のフォルダーを削除しますか？'),
                                  content: Text(
                                      '選択したフォルダーと、フォルダー内のすべてのノートが削除されます。この操作は取り消せません。'),
                                  actions: [
                                    // ボタン領域
                                    FlatButton(
                                      child: Text(
                                        "キャンセル",
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    FlatButton(
                                      child: Text(
                                        "削除",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () async {
                                        await provider.deleteFolders();
                                        await provider.getFoldersNotify();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      : null),
            )
          ],
        ),
        body: SafeArea(
          bottom: true,
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Flexible(
                child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    provider.onReorder(oldIndex, newIndex);
                  },
                  children: getList(context, provider),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                    child: Text(
                  '長押しで並び替えができます',
                  style: TextStyle(
                      color: getWhiteOrBlack(getScaffoldColor(context))),
                )),
                decoration: BoxDecoration(
                  border: const Border(
                    top: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getList(BuildContext context, FolderEditModel provider) {
    List<Folder> folders = provider.folders;
    List<Widget> listItems = List<Widget>();

    folders.asMap().forEach((int index, Folder folder) {
      listItems.add(Container(
        key: Key(folder.id.toString()),
        child: ListItemFolderEdit(
          folder: folder,
          onTapCallback: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FolderDetailPage(
                    folder: Folder(
                        id: folder.id,
                        title: folder.title,
                        color: folder.color,
                        priority: index),
                  ),
                )).then((value) {
              provider.getFoldersNotify();
            });
          },
          checkedCallback: (isCheck) {
            provider.onItemCheck(folder.id, isCheck);
          },
        ),
      ));
    });
    return listItems;
  }
}
