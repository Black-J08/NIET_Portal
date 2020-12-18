import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'functions.dart';

import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class ExamResultsPage extends StatefulWidget {
  @override
  _ExamResultsPageState createState() => _ExamResultsPageState();
}

class _ExamResultsPageState extends State<ExamResultsPage> {
  bool _loadingVisibility = true;
  bool _loadingWebViewVisibility = false;
  String html;

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
      _loadingVisibility = !_loadingVisibility;
      _loadingWebViewVisibility = !_loadingWebViewVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exam Results',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 26, color: Colors.white),
        ),
        centerTitle: true,
        toolbarHeight: 47,
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
            Visibility(
              child: Container(
                height: (MediaQuery.of(context).size.height) / 2,
                width: MediaQuery.of(context).size.width,
                child: InAppWebView(
                  initialUrl: 'http://www.nietcampus.com/Home/',
                  onLoadStop: (controller, url) async {
                    if (url == 'http://www.nietcampus.com/Home/') {
                      await loginController(controller);
                      await controller.loadUrl(
                          url:
                              'http://www.nietcampus.com/Manage/studentview/mydetail.aspx');
                    } else if (url ==
                        'http://www.nietcampus.com/Manage/studentview/mydetail.aspx') {
                      await controller.getHtml().then((value) async {
                        dom.Document document = parser.parse(value);
                        html = document
                            .getElementById(
                                'ctl00_ctl00_ContentPane_ContentPane_WebTab1_tmpl3_Exam1_gdv')
                            .outerHtml
                            .toString();
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
          ],
        ),
      ),
    );
  }
}
