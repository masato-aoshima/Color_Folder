import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/repository/shared_preference.dart';

/// ノートの表示順を設定するダイアログ
class OrderOfNotesDialog extends StatelessWidget {
  OrderOfNotesDialog(this.setting, this.selectCallback);

  final String setting;
  final Function selectCallback;

  @override
  Widget build(BuildContext context) {
    final dialog = SimpleDialog(
      children: getDialogOptions(setting, selectCallback),
    );
    return dialog;
  }
}

List<Widget> getDialogOptions(String savedSetting, Function onPressed) {
  List<Widget> list = <Widget>[];
  orderOfNotesMap.keys.forEach((key) {
    final option = CheckIconDialogOption(savedSetting, key,
        orderOfNotesMap[key], onPressed, DialogType.NoteSortSetting);
    list.add(option);
  });
  return list;
}

class CheckIconDialogOption extends StatelessWidget {
  CheckIconDialogOption(this.savedSetting, this.thisSetting, this.text,
      this.onPressed, this.type);

  final String savedSetting;
  final String thisSetting;
  final String text;
  final Function onPressed;
  final DialogType type;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      child: Row(
        children: [
          Opacity(
            opacity: savedSetting == thisSetting ? 1 : 0,
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            text,
            style: TextStyle(fontSize: 18),
          )),
        ],
      ),
      onPressed: () {
        switch (type) {
          case DialogType.NoteSortSetting:
            saveOrderOfNotesSetting(thisSetting);
            break;
          case DialogType.DisplayDateSetting:
            saveDisplaySubtitleSetting(thisSetting);
            break;
        }
        onPressed(); // TODO ここで設定した内容を返すのもいいかも
      },
    );
  }
}

enum DialogType { NoteSortSetting, DisplayDateSetting }

Future showOrderOfNotesDialog(
    BuildContext context, Function selectCallback) async {
  final setting = await getOrderOfNotesSetting();
  await showDialog(
      context: context,
      builder: (_) {
        return OrderOfNotesDialog(setting, selectCallback);
      });
}
