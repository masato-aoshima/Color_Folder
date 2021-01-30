import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteItemWidget extends StatelessWidget {
  NoteItemWidget({this.id, this.text, this.onTapCallback});

  final int id;
  final String text;
  final Function(int, String) onTapCallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 4.0,
        child: Center(
          child: ListTile(
            title: Text(
              text.split("n").first,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              onTapCallback(id, text);
            },
          ),
        ),
      ),
    );
  }
}
