import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/authentication/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //if (Firebase.apps.isNotEmpty) {
  await Firebase.initializeApp(
    name: "iBuy Admin App",
    options: const FirebaseOptions(
      apiKey: "AIzaSyB-iG_rSPBgG6c4xZuRZCbMcrifR8WiG-M",
      appId: "1:136045114736:web:6b44b8a51c055d819b8bb5",
      messagingSenderId: "136045114736",
      projectId: "freelance-ibuy-app",
      databaseURL: "https://freelance-ibuy-app.firebaseio.com",
    ),
  );
//  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
