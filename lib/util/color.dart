import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FolderGradientMask extends StatelessWidget {
  FolderGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.topLeft,
        colors: [Colors.white, Colors.yellow[700]],
        radius: 0.9,
        tileMode: TileMode.clamp,
      ).createShader(bounds),
      child: child,
    );
  }
}
