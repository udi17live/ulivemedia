import 'package:flutter/material.dart';
import 'package:ulivemedia/main_class.dart';
import 'package:ulivemedia/pages/login_register.dart';
import 'package:ulivemedia/providers/auth_provider.dart';
import 'package:ulivemedia/services/auth_service.dart';

void main() => runApp(UliveMedia());

class UliveMedia extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ulive Aviation Media',
      theme: ThemeData(
        primaryColor: Color(0xFF010F35),
        accentColor: Color(0xFFC5009D),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/loginRegister' : (BuildContext context) => LoginRegisterPage()
      },
      home: MainClass(initialPage: 0,),
    );
  }
}
