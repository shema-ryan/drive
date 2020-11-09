import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _current = 0;
  List<Widget> _screens = [
    StartPage(),
    StartPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: _screens[_current],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[300],
        currentIndex: _current,
        onTap: (value) {
          setState(() {
            _current = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(size: 35),
        showSelectedLabels: false,
        unselectedLabelStyle: GoogleFonts.aBeeZee().copyWith(fontSize: 15),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'recent'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
