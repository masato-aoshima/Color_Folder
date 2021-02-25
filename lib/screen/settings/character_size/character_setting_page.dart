import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/screen/settings/character_size/character_setting_model.dart';
import 'package:sort_note/util/color.dart';

final characterProvider =
    ChangeNotifierProvider((ref) => CharacterSettingModel());

class CharacterSettingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(characterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '文字の設定',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: getWhiteOrBlackByThemeColor(context)),
        ),
      ),
      body: Center(child: Text('文字の設定')),
    );
  }
}
