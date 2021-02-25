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
        return DynamicTheme(data: (brightness) {
          return colorThemeData(color); // 1.ここで作ったthemeが
        }, themedWidgetBuilder: (context, theme) {
          // ここに入る
          return MaterialApp(
            // テーマ変更時リビルドされる
            title: 'Flutter Demo', // TODO
            theme: lightThemeData(context, theme.primaryColor),
            darkTheme: darkThemeData(context, theme.primaryColor),
            home: FolderPage(),
          );
        });
      },
    );
  }
}

ThemeData colorThemeData(Color color) {
  return ThemeData(primaryColor: color);
}

ThemeData lightThemeData(BuildContext context, Color color) {
  return ThemeData(
    brightness: Brightness.light,
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

ThemeData darkThemeData(BuildContext context, Color color) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: color,
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
