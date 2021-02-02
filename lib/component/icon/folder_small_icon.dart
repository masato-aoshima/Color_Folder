import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/util/color.dart';

class FolderSmallIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FolderGradientMask(
      child: Icon(
        Icons.folder_sharp,
        color: Colors.yellow[600],
      ),
    );
  }
}
