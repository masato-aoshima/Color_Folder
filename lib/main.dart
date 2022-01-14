import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sort_note/repository/shared_preference.dart';
import 'package:sort_note/screen/folder_list/folder_list_page.dart';
import 'package:sort_note/util/color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  // 1. ProviderScopeで囲む
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        getThemeColorString(),
        Firebase.initializeApp(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final color = rawStringToColor(snapshot.data[0]);
        return DynamicTheme(data: (brightness) {
          return colorThemeData(color); // 1.ここで作ったthemeが
        }, themedWidgetBuilder: (context, themeMode, themeData) {
          // ここに入る
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: [
              Locale('ja', 'JP'),
            ],
            // テーマ変更時リビルドされる
            title: 'Color Folder',
            themeMode: themeMode,
            theme: lightThemeData(context, themeData.primaryColor),
            darkTheme: darkThemeData(context, themeData.primaryColor),
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
    appBarTheme: AppBarTheme(backgroundColor: color),
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
    appBarTheme: AppBarTheme(backgroundColor: color),
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
