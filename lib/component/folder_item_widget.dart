import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FolderItemWidget extends StatelessWidget {
  FolderItemWidget(
      {this.id, this.title, this.callback, this.longPressCallback});

  final int id;
  final String title;
  final Function(int id, String title) callback;
  final Function(int id, String title) longPressCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: GestureDetector(
              onLongPress: () => longPressCallback(id, title),
              child: IconButton(
                icon: Icon(Icons.folder),
                color: Colors.yellow[600],
                padding: EdgeInsets.all(0.0),
                iconSize: 100,
                onPressed: () => callback(id,title),
              ),
            )),
        Expanded(flex: 1, child: Text(title))
      ],
    );
  }
}
