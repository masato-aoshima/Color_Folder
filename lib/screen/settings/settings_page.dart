import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
              ColorPickerListTile(provider),
            ],
          ),
        ));
  }
}

// アプリのテーマ設定
class ColorPickerListTile extends StatelessWidget {
  ColorPickerListTile(this.provider);

  final SettingsModel provider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: provider.getColor(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListTile(
          leading: Icon(Icons.color_lens, color: snapshot.data),
          title: Text('テーマ'),
          subtitle: Text('アプリのテーマを設定します'),
          onTap: () {
            showDialog(
              context: context,
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: snapshot.data,
                    showLabel: false,
                    pickerAreaHeightPercent: 0.8,
                    onColorChanged: (Color value) {
                      provider.pickerColor = value;
                    },
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('決定'),
                    onPressed: () {
                      provider.onColorSelected(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
