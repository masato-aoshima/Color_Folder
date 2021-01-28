import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FolderItem extends StatelessWidget {
  FolderItem({this.id, this.title, this.callback});

  final int id;
  final String title;
  final Function(int) callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: FittedBox(
                fit: BoxFit.fill,
                child: IconButton(
                  icon: Icon(Icons.folder),
                  color: Colors.yellow[600],
                  padding: EdgeInsets.all(0.0),
                  iconSize: 45,
                  onPressed: () => callback(id),
                ))),
        Expanded(flex: 1, child: Text(title))
      ],
    );
  }
}
