import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/model.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final user = FirebaseAuth.instance.currentUser;
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Column(
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
                        fillColor: Colors.grey[100],
                        border: InputBorder.none,
                        hintText: 'Search',
                        suffixIcon: Icon(Icons.search))),
              ),
            ),
            const SizedBox(
              height: 10,
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
              height: 10,
            ),
            Container(
              height: 280,
              width: double.infinity,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: Data.getCarList.length,
                itemBuilder: (BuildContext context, int index) {
                  print(Data.getCarList.length);
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 200,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
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
                        Image.asset(
                          Data.getCarList[index].images[0],
                          height: 160,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          Data.getCarList[index].model,
                          style: GoogleFonts.lato().copyWith(fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          Data.getCarList[index].brand,
                          style: GoogleFonts.lato()
                              .copyWith(fontSize: 20, color: Colors.brown),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          Data.getCarList[index].condition,
                          style: GoogleFonts.lato().copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.brown[400],
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
                            height: 5,
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
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 10,
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
              height: 120,
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
                          height: 50,
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
                  width: 150,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
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
        backgroundColor: Theme.of(context).accentColor,
        currentIndex: _current,
        onTap: (value) {
          setState(() {
            _current = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(size: 35),
        showSelectedLabels: false,
        selectedLabelStyle: GoogleFonts.lato(),
        unselectedLabelStyle: GoogleFonts.lato(),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'recent'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
