import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majduradda/Services/auth_services.dart';
import 'package:majduradda/components/sqauretile.dart';
import 'package:majduradda/components/button.dart';
import 'package:majduradda/components/textfield.dart';
import 'package:majduradda/pages/home_page.dart'; // Import the AuthService

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Create an instance of AuthService
  final AuthService _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  // ValueNotifier to manage loading state
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  void signUserUp() async {
    // Show loading indicator by updating the ValueNotifier state
    _isLoading.value = true;

    try {
      // Check if passwords match
      if (passwordController.text == confirmpasswordController.text) {
        // Use the AuthService to sign up
        User? user = await _authService.signUp(
          emailController.text, 
          passwordController.text
        );

        // Check if the widget is still mounted before updating the UI
        if (mounted) {
          // Hide loading indicator after sign-up
          _isLoading.value = false;

          if (user != null) {
            // Optional: Navigate to home screen or show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account created successfully!'))
            );

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Homepage(
                  onTap: (p0) {},
                  onTabChange: (p0) {},
                ),
              ),
            );
          }
        }
      } else {
        // Check if the widget is still mounted before showing an error
        if (mounted) {
          // Hide loading indicator and show error if passwords do not match
          _isLoading.value = false;
          showErrorMessage('Passwords do not match!');
        }
      }
    } on FirebaseAuthException catch (e) {
      // Check if the widget is still mounted before showing an error
      if (mounted) {
        // Hide loading indicator and show error if sign-up fails
        _isLoading.value = false;
        showErrorMessage(e.code);
      }
    } catch (e) {
      // Check if the widget is still mounted before showing an error
      if (mounted) {
        // Hide loading indicator and show error if any exception occurs
        _isLoading.value = false;
        showErrorMessage('An error occurred. Please try again.');
      }
    }
  }

  // Method to handle Google Sign-Up
  void signUpWithGoogle() async {
    // Show loading indicator by updating the ValueNotifier state
    _isLoading.value = true;

    try {
      // Use AuthService to sign in with Google
      User? user = await _authService.signInWithGoogle();

      // Check if the widget is still mounted before updating the UI
      if (mounted) {
        // Hide loading indicator after Google sign-up
        _isLoading.value = false;

        if (user != null) {
          // Optional: Navigate to home screen or show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signed in with Google successfully!'))
          );
        }
      }
    } catch (e) {
      // Check if the widget is still mounted before showing an error
      if (mounted) {
        // Hide loading indicator and show error if sign-up fails
        _isLoading.value = false;
        showErrorMessage('Google Sign-In failed');
      }
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
    // Dispose of the ValueNotifier when the widget is disposed
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
                  'Let\'s create an account for you!',
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
                CustomTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                CustomButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
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
                      onTap: signUpWithGoogle, // Updated to use Google Sign-Up method
                      imagePath: 'lib/images/google.png'
                    ),
                    const SizedBox(width: 25),
                    SqaureTile(
                      onTap: () {}, 
                      imagePath: 'lib/images/apple.png'
                    ),
                  ]
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Now',
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
