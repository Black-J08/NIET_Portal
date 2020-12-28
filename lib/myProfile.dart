import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'functions.dart';

import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool _loadingVisibility = true;
  bool _loadingWebViewVisibility = false;
  String html = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void toggleVisibility() {
    setState(() {
      sleep(Duration(milliseconds: 500));
      _loadingVisibility = !_loadingVisibility;
      _loadingWebViewVisibility = !_loadingWebViewVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              child: CircularProgressIndicator(),
              visible: _loadingVisibility,
            ),
            Expanded(
              child: Visibility(
                child: Container(
                  height: (MediaQuery.of(context).size.height),
                  width: MediaQuery.of(context).size.width,
                  child: InAppWebView(
                    initialUrl: 'http://www.nietcampus.com/Home/',
                    onLoadStop: (controller, url) async {
                      if (url == 'http://www.nietcampus.com/Home/') {
                        await loginController(controller);
                        await controller.loadUrl(url: 'http://www.nietcampus.com/Manage/studentview/mydetail.aspx');
                      } else if (url == 'http://www.nietcampus.com/Manage/studentview/mydetail.aspx') {
                        await controller.getHtml().then((value) async {
                          dom.Document document = parser.parse(value);
                          html += document.getElementById('ctl00_ctl00_ContentPane_ContentPane_WebTab1_tmpl0_StudentDetail1_Tad1').outerHtml.toString();
                          html += document.getElementById('divpersonaldetails').innerHtml.toString();
                          html += document.getElementById('divPaddress').innerHtml.toString();
                        });
                        await controller.loadData(data: html);

                        toggleVisibility();
                      }
                    },
                  ),
                ),
                visible: _loadingWebViewVisibility,
                maintainState: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
