import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import 'functions.dart';

class NoticesPage extends StatefulWidget {
  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  int listLenght;
  List list;
  bool fetched = false;

  @override
  void initState() {
    super.initState();
    // getListLenght().then((value) => listLenght = value);
    getList().then((value) {
      setState(() {
        list = value;
        fetched = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notices'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('${list[index].name}'),
              leading: Icon(Icons.picture_as_pdf),
              onTap: () {
                getPdfPath(list[index]).then((value) {
                  OpenFile.open(value);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
