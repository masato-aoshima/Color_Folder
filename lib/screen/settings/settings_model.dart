import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:sort_note/repository/shared_preference.dart';
import 'package:sort_note/util/color.dart';

import '../../main.dart';

class SettingsModel extends ChangeNotifier {
  Color pickerColor;

  Future<Color> getColor() async {
    final colorString = await getThemeColorString();
    final color = rawStringToColor(colorString);
    return color;
  }

  void onColorSelected(BuildContext context) {
    // sharedPreferences に 保存
    saveThemeColor(pickerColor);
    // appThemeに反映
    DynamicTheme.of(context)
        .setThemeData(brightThemeData(context, Brightness.light, pickerColor));
  }
}
