import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/util/color.dart';

class FolderSmallIcon extends StatelessWidget {
  FolderSmallIcon(
      {this.enable = true, this.size = 30, this.color = '0xffffc107'});

  final bool enable;
  final double size;
  final String color;

  @override
  Widget build(BuildContext context) {
    return FolderGradientMask(
      child: Icon(
        Icons.folder_sharp,
        color: enable ? Color(int.parse(color, radix: 16)) : Colors.grey,
        size: size,
      ),
    );
  }
}
