import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/repository/shared_preference.dart';
import 'package:sort_note/util/color.dart';

class CharacterSettingPage extends StatefulWidget {
  @override
  _CharacterSettingPageState createState() => _CharacterSettingPageState();
}

class _CharacterSettingPageState extends State<CharacterSettingPage> {
  double _fontSize = 20;
  double _height = 1.16;

  void _changeSizeSlider(double e) => setState(() {
        _fontSize = e;
      });

  void _changeHeightSlider(double e) => setState(() {
        _height = e;
      });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        saveFontSizeSetting(_fontSize);
        saveFontHeightSetting(_height);
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              '文字の設定',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getWhiteOrBlackByThemeColor(context)),
            ),
          ),
          body: OrientationBuilder(builder: (context, orientation) {
            var orientation = MediaQuery.of(context).orientation;
            return Flex(
              direction: orientation == Orientation.portrait
                  ? Axis.vertical
                  : Axis.horizontal,
              children: [
                Flexible(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: const Text(
                              'デフォルトの設定に戻す',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              _changeSizeSlider(20.0);
                              _changeHeightSlider(1.16);
                            },
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          color: Colors.blue[50],
                          child: Column(
                            children: <Widget>[
                              Center(
                                  child: Text(
                                      "文字の大きさ：${_fontSize.toStringAsFixed(1)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))),
                              CupertinoSlider(
                                min: 12,
                                max: 35,
                                value: _fontSize,
                                activeColor: Colors.blue,
                                onChanged: _changeSizeSlider,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: Colors.blue[200],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Center(
                                  child: Text(
                                "行間の大きさ：${_height.toStringAsFixed(1)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                              CupertinoSlider(
                                min: 1,
                                max: 2,
                                value: _height,
                                activeColor: Colors.blue,
                                onChanged: _changeHeightSlider,
                              ),
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.red,
                    child: Text(
                      '文字のサイズを変更できます文字のサイズを変更できます文字のサイズを変更できます文字のサイズを変更できます文字のサイズを変更できます',
                      style: TextStyle(fontSize: _fontSize, height: _height),
                    ),
                  ),
                )
              ],
            );
          })),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final fontSize = await getFontSizeSetting();
    final height = await getFontHeightSetting();
    _changeSizeSlider(fontSize);
    _changeHeightSlider(height);
  }
}
