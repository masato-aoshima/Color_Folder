import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sort_note/component/icon/folder_small_icon.dart';
import 'package:sort_note/util/color.dart';

import 'folder_default_color_model.dart';

final folderProvider =
    ChangeNotifierProvider((ref) => FolderDefaultColorModel());

class FolderDefaultColorPage extends HookConsumerWidget {
  FolderDefaultColorPage(this.color);

  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(folderProvider)..setColor(color);
    return WillPopScope(
      onWillPop: () {
        provider.clear();
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'デフォルトの色を選択',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getWhiteOrBlackByThemeColor(context)),
            ),
            iconTheme:
                IconThemeData(color: getWhiteOrBlackByThemeColor(context)),
          ),
          body: OrientationBuilder(
            builder: (context, orientation) {
              var orientation = MediaQuery.of(context).orientation;
              if (orientation == Orientation.portrait) {
                return SingleChildScrollView(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    child: Center(
                        child: Column(
                      children: [
                        FolderSmallIcon(
                          color: provider.color,
                          size: 200,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 400.0),
                          child: ColorPicker(
                            pickersEnabled: {
                              ColorPickerType.both: false,
                              ColorPickerType.primary: true,
                              ColorPickerType.accent: false,
                              ColorPickerType.bw: false,
                              ColorPickerType.custom: false,
                              ColorPickerType.wheel: false
                            },
                            enableShadesSelection: false,
                            hasBorder: true,
                            padding: EdgeInsets.all(20),
                            color: provider.color,
                            onColorChanged: (Color color) {
                              print(colorToString(color));
                              provider.selectColor(color);
                            },
                            heading: Text(
                              '最初に選択されている色を変更できます',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          child: Text(
                            '保存',
                            style: TextStyle(
                                color: getWhiteOrBlack(getThemeColor(context)),
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            Navigator.pop(context, provider.color);
                            provider.clear();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: getThemeColor(context)),
                        ),
                      ],
                    )),
                  ),
                );
              } else {
                // 横画面
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                FolderSmallIcon(
                                  color: provider.color,
                                  size: 200,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Center(
                                  child: ConstrainedBox(
                                    constraints:
                                        BoxConstraints(maxWidth: 400.0),
                                    child: ColorPicker(
                                      pickersEnabled: {
                                        ColorPickerType.both: false,
                                        ColorPickerType.primary: true,
                                        ColorPickerType.accent: false,
                                        ColorPickerType.bw: false,
                                        ColorPickerType.custom: false,
                                        ColorPickerType.wheel: false
                                      },
                                      enableShadesSelection: false,
                                      hasBorder: true,
                                      padding: EdgeInsets.all(20),
                                      color: provider.color,
                                      onColorChanged: (Color color) {
                                        print(colorToString(color));
                                        provider.selectColor(color);
                                      },
                                      heading: Text(
                                        'フォルダの色を変更できます',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  child: const Text(
                                    '保存',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, provider.color);
                                    provider.clear();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: getThemeColor(context)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          )),
    );
  }
}
