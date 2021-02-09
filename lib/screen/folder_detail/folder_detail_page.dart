import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';

import 'folder_detail_model.dart';

final folderProvider = ChangeNotifierProvider((ref) => FolderDetailModel());

class FolderDetailPage extends HookWidget {
  FolderDetailPage({this.heroId});

  final String heroId;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(folderProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'フォルダ詳細',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        child: Center(
            child: Hero(
                tag: 'folderSmallIcon$heroId',
                child: FolderSmallIcon(
                  size: 200,
                ))),
      ),
    );
  }
}
