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

const defaultFolderColor = Color(0xffffc107);

/// String -> Color への変換
/// @hexString : 6桁の16進数文字列
Color stringToColor(String hexString) {
  return Color(int.parse("0xff$hexString"));
}

/// Color -> 6桁の16進数への変換
/// 例：Color(0xffcddc39) -> cddc39　へ
String colorToString(Color color) {
  final rawColorString = color.toString();
  return rawColorString.substring(10, 16);
}
