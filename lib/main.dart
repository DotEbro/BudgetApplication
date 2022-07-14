// @dart=2.9
import 'package:budget_app/LogIn/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:budget_app/SplashScreen/splash_screen.dart';
import 'package:budget_app/colours.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('fingerPrint') ?? false;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Budget App',
    theme: ThemeData(primaryColor: primarycolor, primarySwatch: Colors.purple,),
    home: status ? const LogIn() :const SplashScreen(),)
  );
}
