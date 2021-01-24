import 'package:flutter/foundation.dart';

class Folder {
  final int id;
  final String title;
  final int priority;

  Folder({this.id, this.title, this.priority});

  // SQLiteのテーブルにinsertするために、Map型に変換
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'priority': priority,
    };
  }

  // データベースから取り出したレコードを、Folder型に変換
  Folder fromMap(Map<String, dynamic> map) {
    return Folder(
        id: map['id'], title: map['title'], priority: map['priority']);
  }
}
