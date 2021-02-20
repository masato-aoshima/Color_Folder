import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sort_note/screen/settings/settings_model.dart';

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
      body: Center(
        child: Text('設定画面です'),
      ),
    );
  }
}
