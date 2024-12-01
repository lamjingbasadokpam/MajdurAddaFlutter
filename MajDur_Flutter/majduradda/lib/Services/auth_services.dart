import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:majduradda/Database/mangoDatabase.dart'; // Make sure this path is correct

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign up with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      User? user = result.user;

      // Store additional user data in MongoDB
      if (user != null) {
        await MongoDatabase.insert('users', {
          'uid': user.uid,
          'email': user.email,
          'displayName':user.displayName,
          'phoneNumber':user.phoneNumber,
          'photoURL':user.photoURL,
          'lastSignInTime':user.metadata.lastSignInTime,
          'createdAt': DateTime.now().toIso8601String()
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print(e);
      // Re-throw the exception to be handled in the UI
      rethrow;
    }
  }

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      // Re-throw the exception to be handled in the UI
      rethrow;
    }
  }

  // Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      // Store user data in MongoDB
      if (user != null) {
        await MongoDatabase.insert('users', {
          'uid': user.uid,
          'email': user.email,
          'name': user.displayName,
          'photoUrl': user.photoURL,
          'createdAt': DateTime.now().toIso8601String()
        });
      }

      return user;
    } catch (e) {
      // Re-throw the exception to be handled in the UI
      rethrow;
    }
  }
  // Add this method to the existing AuthService class
  Future<User?> signInWithPhoneCredential(PhoneAuthCredential credential) async {
    try {
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      
      // Store user data in MongoDB if the user is not null
      if (user != null) {
        await MongoDatabase.insert('users', {
          'uid': user.uid,
          'phoneNumber': user.phoneNumber,
          'email': user.email,
          'displayName': user.displayName,
          'photoURL': user.photoURL,
          'createdAt': DateTime.now().toIso8601String()
        });
      }
      
      return user;
    } catch (e) {
      rethrow;
    }
  }
  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      rethrow;    
    }
    
  }
}