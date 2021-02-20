import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';
import 'package:sort_note/component/text/text_setting_heading.dart';
import 'package:sort_note/repository/shared_preference.dart';
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
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextSettingHeading('テーマ'),
              MaterialColorPickerSettingsTile(
                icon: Icon(Icons.color_lens_outlined),
                title: 'テーマ',
                subtitle: 'アプリのテーマを設定します',
                settingKey: SharedPreferencesKey.keyThemeColor,
                okCaption: '決定',
                cancelCaption: 'キャンセル',
              ),
              Settings().onStringChanged(
                  settingKey: SharedPreferencesKey.keyThemeColor,
                  defaultValue: '0xff1995AD',
                  childBuilder: (BuildContext context, String value) {
                    print(value);
                    return Container();
                  })
            ],
          ),
        ));
  }
}
