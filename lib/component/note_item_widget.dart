import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteItemWidget extends StatelessWidget {
  NoteItemWidget({this.id, this.text, this.callback, this.longPressCallback});

  final int id;
  final String text;
  final Function(int) callback;
  final Function(int id, String text) longPressCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: GestureDetector(
              onLongPress: () => longPressCallback(id, text),
              child: IconButton(
                icon: Icon(Icons.folder),
                color: Colors.yellow[600],
                padding: EdgeInsets.all(0.0),
                iconSize: 100,
                onPressed: () => callback(id),
              ),
            )),
        Expanded(flex: 1, child: Text(text))
      ],
    );
  }
}
