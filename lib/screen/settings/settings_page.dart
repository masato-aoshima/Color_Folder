import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sort_note/component/text/text_setting_heading.dart';
import 'package:sort_note/screen/settings/settings_model.dart';
import 'package:sort_note/util/color.dart';

// 3. Providerモデルクラスをグローバル定数に宣言
final settingsProvider = ChangeNotifierProvider((ref) => SettingsModel());

class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(settingsProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '設定',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getWhiteOrBlackByThemeColor(context)),
          ),
          iconTheme: IconThemeData(color: getWhiteOrBlackByThemeColor(context)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextSettingHeading('テーマ'),
              ListTile(
                leading: Icon(Icons.color_lens_outlined),
                title: Text('テーマ'),
                subtitle: Text('アプリのテーマを設定します'),
                trailing: ColorIndicator(
                  width: 44,
                  height: 44,
                  borderRadius: 4,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ));
  }
}
