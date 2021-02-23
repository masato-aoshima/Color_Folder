import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sort_note/component/dialog/order_of_notes_dialog.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';
import 'package:sort_note/component/text/text_setting_heading.dart';
import 'package:sort_note/repository/shared_preference.dart';
import 'package:sort_note/screen/settings/folder_default_color/folder_default_color_page.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: ListView(
            children: [
              TextSettingHeading('テーマ'),
              ColorPickerListTile(provider),
              TextSettingHeading('フォルダー'),
              FolderColorSelectListTile(provider),
              TextSettingHeading('ノート'),
              SortNoteListTile(provider),
              NoteDateDisplayListTile(provider),
              WordCountListTile(provider)
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
          leading: Icon(
            Icons.color_lens,
            size: 30,
            color: snapshot.data,
          ),
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
                    child: const Text(
                      'デフォルトの色に戻す',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    onPressed: () {
                      provider.onColorSelectedDefault(context);
                      Navigator.of(context).pop();
                    },
                  ),
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

// フォルダーのデフォルトの色設定
class FolderColorSelectListTile extends StatelessWidget {
  FolderColorSelectListTile(this.provider);

  final SettingsModel provider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: provider.getFolderColor(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListTile(
          leading: FolderSmallIcon(
            color: snapshot.data,
          ),
          title: Text('フォルダーの色'),
          subtitle: Text('フォルダーを新しく作成するときの、最初に選択されている色を変更します'),
          onTap: () async {
            final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FolderDefaultColorPage(snapshot.data),
                    fullscreenDialog: true));
            if (result is Color) {
              provider.saveFolderColor(result);
            }
          },
        );
      },
    );
  }
}

// ノートの並び順を変更
class SortNoteListTile extends StatelessWidget {
  SortNoteListTile(this.provider);

  final SettingsModel provider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: provider.getSortOrder(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListTile(
          leading: Icon(
            Icons.compare_arrows,
            size: 30,
            color: getWhiteOrBlack(getScaffoldColor(context)),
          ),
          title: Text('ノートの並び順'),
          subtitle: Text('現在の設定：${orderOfNotesMap[snapshot.data]}'),
          onTap: () {
            showOrderOfNotesDialog(context, () {
              Navigator.pop(context);
              provider.onRefresh();
            });
          },
        );
      },
    );
  }
}

// ノートの日付表示
class NoteDateDisplayListTile extends StatelessWidget {
  NoteDateDisplayListTile(this.provider);

  final SettingsModel provider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: provider.getDateDisplaySetting(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListTile(
          leading: Icon(
            Icons.subtitles_outlined,
            size: 30,
            color: getWhiteOrBlack(getScaffoldColor(context)),
          ),
          title: Text('ノートのサブタイトル'),
          subtitle: Text('現在の設定：${displaySubtitleMap[snapshot.data]}'),
          onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return SimpleDialog(
                    children: getDialogOptions(snapshot.data, () {
                      Navigator.pop(context);
                      provider.onRefresh();
                    }),
                  );
                });
          },
        );
      },
    );
  }

  List<Widget> getDialogOptions(String savedSetting, Function onPressed) {
    List<Widget> list = List<Widget>();
    displaySubtitleMap.keys.forEach((key) {
      final option = CheckIconDialogOption(savedSetting, key,
          displaySubtitleMap[key], onPressed, DialogType.DisplayDateSetting);
      list.add(option);
    });
    return list;
  }
}

// 現在の文字数の表示
class WordCountListTile extends StatelessWidget {
  WordCountListTile(this.provider);

  final SettingsModel provider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: provider.getWordCountDisplaySetting(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return SwitchListTile(
          secondary: Icon(
            Icons.textsms_outlined,
            size: 30,
            color: getWhiteOrBlack(getScaffoldColor(context)),
          ),
          title: Text('現在の文字数を表示'),
          subtitle: Text('現在の設定：${snapshot.data == true ? 'ON' : 'OFF'}'),
          value: snapshot.data,
          onChanged: (bool value) async {
            await saveWordCountSetting(value);
            provider.onRefresh();
          },
        );
      },
    );
  }
}
