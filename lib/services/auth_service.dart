import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign up method
  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } 
    on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // login method
  Future<void> logIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // logout method
  Future<void> logout() async {
    await _auth.signOut();
  }
}
