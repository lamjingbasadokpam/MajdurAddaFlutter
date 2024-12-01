
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:majduradda/Database/mangoDatabase.dart';
import 'package:majduradda/firebase_options.dart';
import 'package:majduradda/pages/Admin/auth_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
     home: AuthPage(),
    );
  }
}


 