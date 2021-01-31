import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FolderItemWidget extends StatelessWidget {
  FolderItemWidget({this.title, this.callback, this.longPressCallback});
  final String title;
  final Function() callback;
  final Function() longPressCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: GestureDetector(
              onLongPress: () => longPressCallback(),
              child: IconButton(
                icon: Icon(Icons.folder),
                color: Colors.yellow[600],
                padding: EdgeInsets.all(0.0),
                iconSize: 100,
                onPressed: () => callback(),
              ),
            )),
        Expanded(flex: 1, child: Text(title))
      ],
    );
  }
}
