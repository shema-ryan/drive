import 'package:drive/Authentication/RegisterForm.dart';
import 'package:drive/services/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Edit profile',
          onPressed: () {},
          child: Icon(
            Icons.edit,
            color: Theme.of(context).primaryColor,
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                ClipPath(
                  clipper: Clipper(),
                  child: Container(
                    height: 300,
                    width: size.width,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(user.displayName ?? 'An error Occurred'),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(user.email),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text('0703911701'),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {
                    Authentication.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomePage.routeName, (Route<dynamic> route) => false);
                  },
                  leading: Icon(
                    Icons.logout,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text('LogOut'),
                ),
              ],
            ),
            Positioned(
              right: 30,
              top: 130,
              child: CircleAvatar(
                backgroundColor:
                    user.photoURL == null ? Colors.white : Colors.transparent,
                backgroundImage: NetworkImage(user.photoURL),
                radius: 70,
              ),
            ),
          ],
        ));
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height - 55)
      // ..lineTo(50, size.height - 30)
      ..arcToPoint(Offset(150, size.height - 35),
          radius: Radius.elliptical(100, 50), clockwise: false)
      ..lineTo(size.width, size.height - 130)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
