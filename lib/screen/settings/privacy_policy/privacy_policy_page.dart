import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sort_note/util/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'プライバシーポリシー',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getWhiteOrBlackByThemeColor(context)),
          ),
        ),
        body: WebView(
          initialUrl: 'https://flutter-color-folder.web.app/',
        ));
  }
}
