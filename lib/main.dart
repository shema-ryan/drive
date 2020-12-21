import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import './Authentication/authentication.dart';
import './Screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'model/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission _permission = await Geolocator.checkPermission();
  if (!serviceEnabled) {
    serviceEnabled = await Geolocator.openLocationSettings();
  } else {
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
    }
  }

  if (_permission == LocationPermission.always ||
      _permission == LocationPermission.whileInUse) {
    runApp(MyApp());
  } else {
    exit(0);
  }
}

// Color(0xfff3f2f7),
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Data>(
          create: (context) => Data(),
        ),
        ChangeNotifierProvider<OrderCar>(
          create: (context) => OrderCar(),
        ),
      ],
      child: MaterialApp(
        title: 'drive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(),
          primarySwatch: Colors.blueGrey,
          accentColor: Color(0xfff3f2f7),
        ),
        home: StreamBuilder(
            stream: _auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                );
              } else if (snapshot.hasData) {
                if (!FirebaseAuth.instance.currentUser.emailVerified) {
                  return Verification();
                } else {
                  return FirstScreen();
                }
              } else {
                return HomePage();
              }
            }),
        routes: {
          FirstScreen.routeName: (context) => FirstScreen(),
          ForgetPassword.routeName: (BuildContext context) => ForgetPassword(),
          HomePage.routeName: (BuildContext context) => HomePage(),
          StartPage.routeName: (BuildContext context) => StartPage(),
          AvailableCars.routeName: (BuildContext context) => AvailableCars(),
          DetailsScreen.routeName: (BuildContext context) => DetailsScreen(),
          BookPage.routeName: (BuildContext context) => BookPage(),
          BookingPage.routeName: (BuildContext context) => BookingPage(),
          RecentBookings.routeName: (BuildContext context) => RecentBookings(),
        },
        onUnknownRoute: (settings) {
          if (settings.name == null) {
            Navigator.of(context).pushNamed(HomePage.routeName);
          }
          return MaterialPageRoute(builder: (context) => HomePage());
        },
      ),
    );
  }
}
