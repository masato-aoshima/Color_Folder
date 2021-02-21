import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/repository/shared_preference.dart';
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
    return FutureBuilder(
      future: getThemeColorString(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final color = rawStringToColor(snapshot.data);
        return DynamicTheme(
            defaultBrightness: Brightness.light,
            data: (brightness) {
              return brightThemeData(context, brightness, color);
            },
            themedWidgetBuilder: (context, theme) {
              return MaterialApp(
                // テーマ変更時リビルドされる
                title: 'Flutter Demo',
                theme: theme,
                home: FolderPage(),
              );
            });
      },
    );
  }
}

ThemeData brightThemeData(
    BuildContext context, Brightness brightness, Color color) {
  return ThemeData(
    brightness: brightness,
    primarySwatch: Colors.blue,
    primaryColor: color,
    scaffoldBackgroundColor: Color(0xffF1F1F2),
    iconTheme: IconThemeData(color: getWhiteOrBlackByThemeColor(context)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: color, foregroundColor: getWhiteOrBlack(color)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
