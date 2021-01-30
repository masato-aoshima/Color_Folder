import 'package:flutter/foundation.dart';

class Note {
  final int id;
  final String text;
  final int priority;
  final int folderId;

  Note({this.id, this.text, this.priority = 0, this.folderId});

  // SQLiteのテーブルにinsertするために、Map型に変換
  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'priority': priority, 'folderId': folderId};
  }

  // データベースから取り出したレコードを、Folder型に変換
  Note fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'],
        text: map['title'],
        priority: map['priority'],
        folderId: map['folderId']);
  }
}
