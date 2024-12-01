import 'package:flutter/material.dart';
import 'package:majduradda/Services/auth_services.dart';
import 'package:majduradda/components/sqauretile.dart';
import 'package:majduradda/components/button.dart';
import 'package:majduradda/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import the AuthService

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  void signUserIn() async {
    _isLoading.value = true;

    try {
      await _authService.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      _isLoading.value = false;

    } on FirebaseAuthException catch (e) {
      _isLoading.value = false;
      showErrorMessage(e.code);
    }
  }

  void signInWithGoogle() async {
    _isLoading.value = true;

    try {
      User? user = await _authService.signInWithGoogle();

      _isLoading.value = false;

      if (user != null) {
        
      }
    } catch (e) {
      _isLoading.value = false;
      showErrorMessage('Google Sign-In failed');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red[400],
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 100,
                  color: Color(0xFF345382),
                ),
                const SizedBox(height: 50),
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                CustomButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    SqaureTile(
                      onTap: signInWithGoogle, // Updated to use Google Sign-In method
                      imagePath: 'lib/images/google.png',
                    ),
                    const SizedBox(width: 25),
                    SqaureTile(
                      onTap: () {}, 
                      imagePath: 'lib/images/apple.png',
                    ),
                  ]
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),

                // Using ValueListenableBuilder to show the loading dialog based on _isLoading state
                ValueListenableBuilder<bool>(
                  valueListenable: _isLoading,
                  builder: (context, isLoading, child) {
                    if (isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF345382),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink(); // Return an empty widget when not loading
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
