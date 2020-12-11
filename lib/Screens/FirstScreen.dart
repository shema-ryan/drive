import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens.dart';

class FirstScreen extends StatefulWidget {
  static final String routeName = '/FirstScreen';
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _current = 0;
  List<Widget> _screens = [
    StartPage(),
    RecentBookings(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: _screens[_current],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _current,
        onTap: (value) {
          setState(() {
            _current = value;
          });
        },
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: true,
        selectedLabelStyle: GoogleFonts.aBeeZee().copyWith(fontSize: 15),
        showUnselectedLabels: false,
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
