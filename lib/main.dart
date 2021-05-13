import 'package:flutter/material.dart';
import 'package:foster_app/Start.dart';
import 'package:foster_app/Login.dart';
import 'package:foster_app/SignUp.dart';
import 'package:foster_app/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange, scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      //home: MyHomePage(title: 'Foster Home Page'),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "start": (BuildContext context) => Start(),
      },
    );
  }
}