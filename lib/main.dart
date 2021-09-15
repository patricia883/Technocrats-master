import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_projects/screens/admin_dashboard.dart';
import 'package:flutter_projects/screens/customer_dashboard.dart';
import 'package:flutter_projects/services/auth.dart';
import 'package:flutter_projects/services/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YSF IT Solutions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(
        auth: Auth(), key: null,
      ),
      routes:
      {
        HomeScreen.routeName: (ctx)=> HomeScreen(),
        Customer_Dashboard.routename: (ctx)=> Customer_Dashboard(),
      },
    );
  }
}
