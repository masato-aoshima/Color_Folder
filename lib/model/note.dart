class Note {
  final int id;
  final String text;
  final String createdAt;
  final String updatedAt;
  final int folderId;

  Note({
    this.id,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.folderId,
  });

  // SQLiteのテーブルにinsertするために、Map型に変換
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'folderId': folderId,
    };
  }

  // データベースから取り出したレコードを、Folder型に変換
  Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      text: map['text'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      folderId: map['folderId'],
    );
  }
}
