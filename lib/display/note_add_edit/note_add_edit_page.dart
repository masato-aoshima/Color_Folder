import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sort_note/display/note_list/note_model.dart';
import 'package:sort_note/model/note.dart';

class NoteAddEditPage extends HookWidget {
  NoteAddEditPage(this.noteId, this.noteText, this.noteProvider);

  final NoteModel noteProvider;
  final int noteId;
  final String noteText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(noteId.toString()),
        ),
        body: Text(noteText));
  }
}
