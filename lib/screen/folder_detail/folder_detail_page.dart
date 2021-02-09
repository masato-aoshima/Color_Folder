import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/list_item/list_item_folder_edit.dart';

import 'folder_detail_model.dart';

final folderProvider = ChangeNotifierProvider((ref) => FolderDetailModel());

class FolderDetailPage extends HookWidget {
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
      ),
    );
  }
}
