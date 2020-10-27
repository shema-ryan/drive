import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import './Authentication/authentication.dart';
import './Screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'drive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        primarySwatch: Colors.brown,
        accentColor: Colors.brown[100],
      ),
      home: StreamBuilder(
          stream: _auth.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              if (!FirebaseAuth.instance.currentUser.emailVerified) {
                return Verification();
              } else {
                return StartPage();
              }
            } else {
              return HomePage();
            }
          }),
      routes: {
        ForgetPassword.routeName: (BuildContext context) => ForgetPassword(),
        HomePage.routeName: (BuildContext context) => HomePage(),
      },
    );
  }
}
