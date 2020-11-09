import 'package:drive/services/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              Authentication.signOut();
            },
            icon: Icon(
              Icons.settings,
              color: Colors.brown,
            ),
          ),
        ],
      ),
      drawer: user.email == 'kamanzishema@gmail.com' ? Drawer() : null,
    );
  }
}
