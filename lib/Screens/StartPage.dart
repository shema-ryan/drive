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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Deals',
                  style: GoogleFonts.lato().copyWith(
                    fontSize: 20,
                    color: Colors.grey[400],
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
          ],
        ),
      ),
    );
  }
}
