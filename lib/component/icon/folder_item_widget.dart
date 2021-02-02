import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/util/color.dart';

class FolderItemWidget extends StatelessWidget {
  FolderItemWidget(
      {this.title, this.callback, this.longPressCallback, this.enable = true});

  final String title;
  final Function() callback;
  final Function() longPressCallback;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: GestureDetector(
              onLongPress: () {
                if (longPressCallback != null) {
                  longPressCallback();
                }
              },
              child: FolderGradientMask(
                child: IconButton(
                  icon: Icon(Icons.folder),
                  color: enable ? Colors.yellow[600] : Colors.grey,
                  padding: EdgeInsets.all(0.0),
                  iconSize: 100,
                  onPressed: () {
                    if (enable) {
                      callback();
                    }
                  },
                ),
              ),
            )),
        Expanded(flex: 1, child: Text(title))
      ],
    );
  }
}
