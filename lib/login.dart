import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = TextEditingController();
  final pass = TextEditingController();

  HeadlessInAppWebView headlessLoginWebView;

  @override
  void initState() {
    super.initState();

    headlessLoginWebView = new HeadlessInAppWebView(
      initialUrl: 'http://www.nietcampus.com/Home/',
    );

    headlessLoginWebView.run();
  }

  @override
  void dispose() {
    super.dispose();
    headlessLoginWebView.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 7),
              child: TextField(
                controller: user,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Enter User ID'),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(50, 7, 50, 10),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(hintText: 'Enter Password'),
                obscureText: true,
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text('Login'),
                onPressed: () async {
                  await headlessLoginWebView.webViewController.evaluateJavascript(source: """
                  document.getElementById('txtUserName').value = '${user.text}';
                  document.getElementById('txtPassword').value = '${pass.text}';
                  document.getElementById('Ulogin').click();
                  """);

                  final dir = await getApplicationDocumentsDirectory();
                  final file = File('${dir.path}/data.txt');
                  file.writeAsString('${user.text}:${pass.text}');

                  Navigator.pushReplacementNamed(context, 'home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
