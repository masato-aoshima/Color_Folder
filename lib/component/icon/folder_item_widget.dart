import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';
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
    return ListTile(
      leading: FolderSmallIcon(),
      title: Text(title),
      enabled: enable,
      onTap: callback,
      onLongPress: longPressCallback,
    );
  }
}
