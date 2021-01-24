import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FolderItem extends StatelessWidget {
  FolderItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: FittedBox(
                fit: BoxFit.fill, child: Icon(Icons.folder_outlined))),
        Expanded(flex: 1, child: Text(text))
      ],
    );
  }
}
