import 'package:carousel_slider/carousel_slider.dart';
import 'package:drive/model/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = '/DetailsScreen';
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _selected =
        ModalRoute.of(context).settings.arguments as Map<String, Car>;
    Car _selectedCar = _selected['selected'];
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF71482A),
          ),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          _selectedCar.model,
          style: GoogleFonts.aBeeZee()
              .copyWith(fontSize: 20, color: Color(0xFF71482A)),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          CarouselSlider.builder(
            itemCount: _selectedCar.images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.brown[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(_selectedCar.images[index]),
                ),
              );
            },
            options: CarouselOptions(
              height: 200,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlayInterval: Duration(seconds: 1),
              autoPlayCurve: Curves.easeInOut,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
