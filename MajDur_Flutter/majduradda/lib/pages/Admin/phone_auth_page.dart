import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majduradda/Services/auth_services.dart';
import 'package:majduradda/pages/home_page.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
   State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  // Create an instance of AuthService
  final AuthService _authService = AuthService();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  
  String verificationId = '';
  bool isOtpSent = false;

  Future<void> sendOtp() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Attempt to sign in using AuthService
          User? user = await _authService.signInWithPhoneCredential(credential);
          if (user != null) {
            _navigateToHomePage();
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        codeSent: (String verId, int? resendToken) {
          setState(() {
            verificationId = verId;
            isOtpSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP sent successfully!')),
          );
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text.trim(),
      );
      
      // Use AuthService to sign in with phone credential
      User? user = await _authService.signInWithPhoneCredential(credential);
      
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone number verified successfully!')),
        );
        _navigateToHomePage();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP: $e')),
      );
    }
  }

  void _navigateToHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Homepage(
          onTap: (p0) {},
          onTabChange: (p0) {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isOtpSent)
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '+1234567890',
                  border: OutlineInputBorder(),
                ),
              ),
            if (isOtpSent)
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isOtpSent ? verifyOtp : sendOtp,
              child: Text(isOtpSent ? 'Verify OTP' : 'Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}