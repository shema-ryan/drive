import 'package:drive/Screens/Available.dart';
import 'package:drive/Screens/DetailsCar.dart';
import 'package:drive/services/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/model.dart';
import 'package:flutter/services.dart';

class StartPage extends StatefulWidget {
  static const String routeName = '/startPage';
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final user = FirebaseAuth.instance.currentUser;
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
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
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Drive',
          style:
              GoogleFonts.mcLaren().copyWith(fontSize: 20, color: Colors.brown),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: TextField(
                    onSubmitted: (value) {
                      print('hello this might look fun ');
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: InputBorder.none,
                        hintText: 'Search',
                        suffixIcon: Icon(Icons.search))),
              ),
            ),
            SizedBox(
              height: size.height * 0.013,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Deals',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'View all>>',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 15,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.013,
            ),
            Container(
              height: size.height * 0.37,
              width: double.infinity,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: Data.getCarList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    width: size.width * 0.51,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.brown[300],
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                DetailsScreen.routeName,
                                arguments: <String, Car>{
                                  'selected': Data.getCarList[index]
                                });
                          },
                          child: Hero(
                            tag: Data.getCarList[index].model,
                            child: Image.asset(
                              Data.getCarList[index].images[0],
                              height: size.height * 0.21,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.013,
                        ),
                        Text(
                          Data.getCarList[index].model,
                          style: GoogleFonts.lato()
                              .copyWith(fontSize: 17, color: Colors.white),
                        ),
                        SizedBox(
                          height: size.height * 0.007,
                        ),
                        Text(
                          Data.getCarList[index].brand,
                          style: GoogleFonts.lato()
                              .copyWith(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: size.height * 0.007,
                        ),
                        Text(
                          Data.getCarList[index].condition,
                          style: GoogleFonts.lato()
                              .copyWith(fontSize: 13, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.013,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AvailableCars.routeName);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xFFDE925C),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available Cars',
                            style: GoogleFonts.lato()
                                .copyWith(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          Text(
                            'Short terms and Long terms',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      Container(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFDE925C),
                        ),
                        alignment: Alignment.center,
                        height: size.height * 0.05,
                        width: size.width * 0.101,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: size.height * 0.013,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Dealers',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'View all>>',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 15,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Data.getDealerList.length,
                itemBuilder: (BuildContext context, int index) => Container(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(
                          Data.getDealerList[index].image,
                          height: size.height * .06,
                        ),
                      ),
                      Text(
                        Data.getDealerList[index].name,
                        style: GoogleFonts.mcLaren().copyWith(
                          fontSize: 20,
                        ),
                      ),
                      Text('${Data.getDealerList[index].offers}')
                    ],
                  ),
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(5.0),
                  width: size.width * 0.38,
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      drawer: user.email == 'kamanzishema@gmail.com' ? Drawer() : null,
    );
  }
}
