import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/util/color.dart';

import 'folder_detail_model.dart';

final folderProvider = ChangeNotifierProvider((ref) => FolderDetailModel());

class FolderDetailPage extends HookWidget {
  FolderDetailPage({this.folder});

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(folderProvider)
      ..folder = folder
      ..color = folder == null ? defaultFolderColor : folder.color;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          folder == null ? '新規作成' : 'フォルダ詳細',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        child: Center(
            child: Column(
          children: [
            Hero(
                tag: folder == null ? '' : 'folderSmallIcon${folder.id}',
                child: FolderSmallIcon(
                  size: 200,
                )),
            ColorPicker(
              pickersEnabled: {
                ColorPickerType.both: false,
                ColorPickerType.primary: true,
                ColorPickerType.accent: false,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.wheel: false
              },
              enableShadesSelection: false,
              hasBorder: true,
              padding: EdgeInsets.all(20),
              color: provider.color,
              onColorChanged: (Color color) {
                // TODO アイテムの保存
                print(colorToString(color));
                provider.selectColor(color);
              },
              heading: Text(
                'フォルダの色を変更できます',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
