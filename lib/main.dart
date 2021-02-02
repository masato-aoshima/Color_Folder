import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/screen/folder_list/folder_page.dart';

void main() {
  // 1. ProviderScopeで囲む
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '並び替え　メモ帳',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FolderPage(),
    );
  }
}
