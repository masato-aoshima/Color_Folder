import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteItemWidget extends StatelessWidget {
  NoteItemWidget({this.text, this.onTapCallback, this.onLongPressCallback});

  final String text;
  final Function() onTapCallback;
  final Function() onLongPressCallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 4.0,
        child: Center(
          child: ListTile(
            title: Text(
              text.split("\n").first,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              onTapCallback();
            },
            onLongPress: () {
              onLongPressCallback();
            },
          ),
        ),
      ),
    );
  }
}
