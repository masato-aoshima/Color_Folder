import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FolderItem extends StatelessWidget {
  FolderItem({this.id, this.title, this.callback, this.longPressCallback});

  final int id;
  final String title;
  final Function(int) callback;
  final Function(int) longPressCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: GestureDetector(
              onLongPress: () => longPressCallback(id),
              child: IconButton(
                icon: Icon(Icons.folder),
                color: Colors.yellow[600],
                padding: EdgeInsets.all(0.0),
                iconSize: 100,
                onPressed: () => callback(id),
              ),
            )),
        Expanded(flex: 1, child: Text(title))
      ],
    );
  }
}
