import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/screen/folder_list/folder_list_page.dart';
import 'package:sort_note/util/color.dart';

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
        primaryColor: Color(0xff1995AD),
        scaffoldBackgroundColor: Color(0xffF1F1F2),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xff1995AD), // TODO
            foregroundColor: getWhiteOrBlack(Color(0xff1995AD))), // TODO
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: FolderPage(),
    );
  }
}
