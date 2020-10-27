import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  static Future<void> signUp(
      {String username,
      String email,
      String phoneNumber,
      String password}) async {
    final _auth = FirebaseAuth.instance;
    try {
      print(email);
      print(password);
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        value.user.sendEmailVerification();
        FirebaseFirestore.instance.collection('Users').doc(value.user.uid).set({
          'uid': value.user.uid,
          'username': username,
          'email': email,
          'phoneNumber': phoneNumber,
        });
      });
    } on FirebaseException catch (e) {
      var message = e.message;
      throw message;
    }
  }

  static Future<UserCredential> singIn({String email, String password}) async {
    final _auth = FirebaseAuth.instance;
    UserCredential _user;
    print('email :' + email ?? 'no email');
    print('password :' + password ?? 'no password');
    try {
      _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      String message = e.message;
      throw message;
    }
    return _user;
  }

  static Future<void> signOut() async {
    final _auth = FirebaseAuth.instance;
    await _auth.signOut();
  }

  static Future<void> resetPassword({String email}) async {
    final _auth = FirebaseAuth.instance;
    await _auth.sendPasswordResetEmail(email: email);
  }
}
