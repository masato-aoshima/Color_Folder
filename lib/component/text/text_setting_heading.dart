import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 設定画面の見出しテキスト
class TextSettingHeading extends StatelessWidget {
  TextSettingHeading(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: (TextStyle(
          color: Colors.blue[700], fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}
