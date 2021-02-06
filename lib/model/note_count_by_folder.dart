class NoteCountByFolder {
  final int folderId;
  final int count;

  NoteCountByFolder({this.folderId, this.count});
}

// データベースから取り出したレコードを、Folder型に変換
NoteCountByFolder fromMapNoteCountByFolder(Map<String, dynamic> map) {
  return NoteCountByFolder(
    folderId: map['folderId'],
    count: map['count(*)'],
  );
}
