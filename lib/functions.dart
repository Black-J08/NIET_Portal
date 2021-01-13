import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/data.txt');
}

Future<String> retrieveData() async {
  String data;
  File file = await _localFile;
  await file.readAsString().then((value) {
    data = value;
  });
  return data;
}

Future<String> getUid() async {
  String uid;
  await retrieveData().then((String value) {
    uid = value.split(':')[0];
  });
  return uid;
}

Future<String> getPass() async {
  String pass;
  await retrieveData().then((String value) {
    pass = value.split(':')[1];
  });
  return pass;
}

Future<void> loginController(InAppWebViewController controller) async {
  String uid;
  String pass;

  await getUid().then((value) => uid = value);
  await getPass().then((value) => pass = value);

  await controller.evaluateJavascript(source: """
  document.getElementById('txtUserName').value = '$uid';
  document.getElementById('txtPassword').value = '$pass';
  document.getElementById('Ulogin').click();
  """);
}

void logOut() async{
  File file = await _localFile;
  file.delete();
}

Future<bool> isLoggedIn() async {
  File file = await _localFile;
  return file.existsSync();
}

Future<List> getList() async {
  firebase_storage.ListResult result = await firebase_storage.FirebaseStorage.instance.ref().child('Notices').listAll();
  return result.items;
}

// Future<int> getListLenght() async {
//   firebase_storage.ListResult result = await firebase_storage.FirebaseStorage.instance.ref().child('Notices').listAll();
//   return result.items.length;
// }

Future<String> getPdfPath(firebase_storage.Reference ref) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  File downloadToFile = File('${appDocDir.path}/${ref.name}');
  ref.writeToFile(downloadToFile);
  return downloadToFile.path;
}