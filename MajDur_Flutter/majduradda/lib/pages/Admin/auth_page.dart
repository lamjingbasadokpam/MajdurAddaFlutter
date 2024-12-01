
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majduradda/pages/Admin/loginorregister_page.dart';
import 'package:majduradda/pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Homepage(
              onTap: (p0) {},
              onTabChange: (p0) {},
            );
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}