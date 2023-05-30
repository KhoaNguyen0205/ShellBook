import 'package:flutter/material.dart';
import 'package:sell_book/pages/DetailsPage.dart';
import 'package:sell_book/pages/HomePage.dart';
import 'package:sell_book/pages/LogOut.dart';
import 'package:sell_book/pages/LoginPage.dart';
import 'package:sell_book/pages/SearchPage.dart';
import 'package:sell_book/pages/TabItemPage.dart';
import 'package:sell_book/pages/changePass.dart';
import 'package:sell_book/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(primarySwatch: Colors.red),
      home: SplashPage(),
    );
  }
}
