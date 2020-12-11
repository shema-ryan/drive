import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Authentication {
  static Future<void> signUp(
      {String username,
      String email,
      String phoneNumber,
      String password,
      File file}) async {
    String imageUrl;
    final _auth = FirebaseAuth.instance;
    final fs = FirebaseStorage.instance;
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await fs.ref('images/$email.png').putFile(file);
        await fs.ref('images/$email.png').getDownloadURL().then((value) {
          imageUrl = value;
        });
        value.user.sendEmailVerification();
        value.user.updateProfile(displayName: username, photoURL: imageUrl);
        FirebaseFirestore.instance.collection('Users').doc(value.user.uid).set({
          'uid': value.user.uid,
          'username': username,
          'email': email,
          'phoneNumber': phoneNumber,
          'imageUrl': imageUrl,
        });
      });
    } on FirebaseException catch (e) {
      var message = e.message;
      print(' the error is -------------> : $message');
      // throw message;
    }
  }

  static Future<UserCredential> singIn({String email, String password}) async {
    final _auth = FirebaseAuth.instance;
    UserCredential _user;
    try {
      _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      String message = e.message;
      print(e.message);
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
