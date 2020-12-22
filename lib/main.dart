import 'package:flutter/material.dart';
import 'functions.dart';
import 'login.dart';
import 'examResults.dart';

bool _isLoggedIn = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await isLoggedIn().then((value) => _isLoggedIn = value);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NIET Portal',
      theme: ThemeData(
        primaryColor: Colors.blue[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        'home': (context) => MyHomePage(),
        'login': (context) => LoginPage(),
        '/examResults': (context) => ExamResultsPage(),
      },
      home: MyHomePage(),
      initialRoute: _isLoggedIn ? 'home' : 'login',
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NIET Portal'),
        centerTitle: true,
      ),
      body: Center(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.width / 4,
                      margin: EdgeInsets.all(5),
                      child: RaisedButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.description_outlined,
                              size: 52,
                            ),
                            Text('Notices'),
                          ],
                        ),
                        color: Colors.blue[700],
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.width / 4,
                      margin: EdgeInsets.all(5),
                      child: RaisedButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 52,
                            ),
                            Text('Mail'),
                          ],
                        ),
                        color: Colors.blue[700],
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.width / 4,
                      margin: EdgeInsets.all(5),
                      child: RaisedButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.addchart_outlined,
                              size: 52,
                            ),
                            Text('Exam Results'),
                          ],
                        ),
                        color: Colors.blue[700],
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(context, '/examResults');
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.width / 4,
                      margin: EdgeInsets.all(5),
                      child: RaisedButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_circle_outlined,
                              size: 52,
                            ),
                            Text('My Profile'),
                          ],
                        ),
                        color: Colors.blue[700],
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
