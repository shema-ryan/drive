import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './RegisterForm.dart';

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please check your email for verification',
              style: GoogleFonts.aBeeZee().copyWith(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pushNamed(HomePage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
