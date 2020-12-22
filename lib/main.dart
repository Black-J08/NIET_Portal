import 'package:flutter/material.dart';
import 'login.dart';
import 'examResults.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var isLoggedIn = (<!something_that_get_stored_after_login!> == null) ? false : true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NIET Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/examResults': (context) => ExamResultsPage(),
      },
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NIET Portal',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 26,
                color: Colors.white)),
        centerTitle: true,
        toolbarHeight: 47,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.width / 4,
                  margin: EdgeInsets.all(5),
                  child: RaisedButton(
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 52,
                        ),
                        Text(
                          'Notices',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    color: Colors.blueAccent,
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
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 52,
                        ),
                        Text(
                          'Mail',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    color: Colors.blueAccent,
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
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.addchart_outlined,
                          size: 52,
                        ),
                        Text(
                          'Exam Results',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    color: Colors.blueAccent,
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
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          size: 52,
                        ),
                        Text(
                          'My Profile',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
