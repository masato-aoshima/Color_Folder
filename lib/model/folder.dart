import 'dart:ui';

import 'package:sort_note/util/color.dart';

class Folder {
  final int id;
  final String title;
  final Color color;
  final int priority;

  Folder(
      {this.id,
      this.title,
      this.color = defaultFolderColor,
      this.priority = 0});

  // SQLiteのテーブルにinsertするために、Map型に変換
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'color': colorToString(color),
      'priority': priority,
    };
  }

  // データベースから取り出したレコードを、Folder型に変換
  Folder fromMap(Map<String, dynamic> map) {
    return Folder(
        id: map['id'],
        title: map['title'],
        color: stringToColor(map['color']),
        priority: map['priority']);
  }
}
