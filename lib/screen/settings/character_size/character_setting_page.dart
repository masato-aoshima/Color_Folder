import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/util/color.dart';

class CharacterSettingPage extends StatefulWidget {
  @override
  _CharacterSettingPageState createState() => _CharacterSettingPageState();
}

class _CharacterSettingPageState extends State<CharacterSettingPage> {
  double _value = 20;

  void _changeSlider(double e) => setState(() {
        _value = e;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        color: Colors.blue[50],
                        child: Column(
                          children: <Widget>[
                            Center(
                                child: Text("文字の大きさ：$_value",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
                            CupertinoSlider(
                              min: 5,
                              max: 40,
                              value: _value,
                              activeColor: Colors.blue,
                              divisions: 10,
                              onChanged: _changeSlider,
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
                              "行間の大きさ：$_value",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                            CupertinoSlider(
                              min: 5,
                              max: 40,
                              value: _value,
                              activeColor: Colors.blue,
                              divisions: 10,
                              onChanged: _changeSlider,
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
                      '文字のサイズを変更できます文字のサイズを変更できます文字のサイズを変更できます文字のサイズを変更できます文字のサイズを変更できます'),
                ),
              )
            ],
          );
        }));
  }
}
