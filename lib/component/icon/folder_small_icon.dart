import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/util/color.dart';

class FolderSmallIcon extends StatelessWidget {
  FolderSmallIcon(
      {this.enable = true, this.size = 30, this.color = defaultFolderColor});

  final bool enable;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FolderGradientMask(
      child: Icon(
        Icons.folder_sharp,
        color: color,
        size: size,
      ),
    );
  }
}
