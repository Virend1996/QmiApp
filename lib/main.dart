
import 'package:flutter/material.dart';
import 'package:qmi_app/screens/LoginScreen.dart';
import 'package:qmi_app/screens/SplashScreen.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen())

    /* home: BottomNavScreen())*/
  );
}