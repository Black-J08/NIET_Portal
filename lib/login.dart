import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'main.dart';

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
        title: Text(
          'Login',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 26, color: Colors.white),
        ),
        centerTitle: true,
        toolbarHeight: 47,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.blue[200],
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.fromLTRB(50, 10, 50, 7),
              child: TextField(
                controller: user,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter User ID',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            Container(
              color: Colors.blue[200],
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.fromLTRB(50, 7, 50, 10),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 80),
            RaisedButton(
              color: Colors.blue[800],
              padding: EdgeInsets.all(8),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              onPressed: () async {
                await headlessLoginWebView.webViewController
                    .evaluateJavascript(source: """
                  document.getElementById('txtUserName').value = '${user.text}';
                  document.getElementById('txtPassword').value = '${pass.text}';
                  document.getElementById('Ulogin').click();
                  """);

                final dir = await getApplicationDocumentsDirectory();
                final file = File('${dir.path}/data.txt');
                file.writeAsString('${user.text}:${pass.text}');
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
                //  Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
