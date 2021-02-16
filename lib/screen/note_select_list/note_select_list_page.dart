import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sort_note/component/list_item/list_item_note.dart';
import 'package:sort_note/model/folder.dart';
import 'package:sort_note/model/note.dart';
import 'package:sort_note/screen/note_select_list/note_select_list_model.dart';

final noteProvider = ChangeNotifierProvider((ref) => NoteSelectListModel());

class NoteSelectListPage extends HookWidget {
  NoteSelectListPage(this.folder);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(noteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ノート選択',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: folder.color,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [],
      ),
      body: FutureBuilder(
        future: provider.getNotes(folder.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return getNoteSelectListView(context, snapshot.data, provider);
        },
      ),
    );
  }

  Widget getNoteSelectListView(
      BuildContext context, List<Note> notes, NoteSelectListModel provider) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        itemCount: notes.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.grey),
        itemBuilder: (BuildContext context, int index) {
          final note = notes[index];
          return ListItemNote(
            note: note,
          );
        },
      ),
    );
  }
}
