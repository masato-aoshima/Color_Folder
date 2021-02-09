class Folder {
  final int id;
  final String title;
  final String color;
  final int priority;

  Folder({this.id, this.title, this.color = '0xffffc107', this.priority = 0});

  // SQLiteのテーブルにinsertするために、Map型に変換
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'color': color,
      'priority': priority,
    };
  }

  // データベースから取り出したレコードを、Folder型に変換
  Folder fromMap(Map<String, dynamic> map) {
    return Folder(
        id: map['id'],
        title: map['title'],
        color: map['color'],
        priority: map['priority']);
  }
}
