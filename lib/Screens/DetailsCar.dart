import 'package:carousel_slider/carousel_slider.dart';
import 'package:drive/model/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = '/DetailsScreen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<T> _map<T>(
      {List<String> images, Function(int index, String imageUrl) handler}) {
    List<T> _get = [];
    for (int i = 0; i < images.length; i++) {
      _get.add(handler(i, images[i]));
    }
    return _get;
  }

  String _month = '12 months';
  String _price = '4350';
  int _current = 0;
  int _select = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
          _selectedCar.brand,
          style: GoogleFonts.aBeeZee()
              .copyWith(fontSize: 25, color: Color(0xFF71482A)),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: [
          SizedBox(
            height: size.height * 0.045,
          ),
          Hero(
            tag: _selectedCar.model,
            child: CarouselSlider.builder(
              itemCount: _selectedCar.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(5.0),
                  width: size.height * 0.52,
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      _selectedCar.images[index],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                height: size.height * 0.32,
                initialPage: 0,
                enlargeCenterPage: true,
                autoPlayInterval: Duration(seconds: 20),
                autoPlayCurve: Curves.easeInOut,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _map<Widget>(
                  images: _selectedCar.images,
                  handler: (ind, imageUrl) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                      height: 5,
                      width: _current == ind ? 20 : 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: _current == ind ? Colors.brown : Colors.grey,
                      ),
                    );
                  })),
          SizedBox(
            height: size.height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCard(size.height * 0.14, size.height * 0.15, '12 months',
                  '4350', 0),
              _buildCard(size.height * 0.14, size.height * 0.15, '6 months',
                  '4800', 1),
              _buildCard(
                  size.height * 0.14, size.height * 0.15, '1 month', '5100', 2),
            ],
          ),
          SizedBox(
            height: size.height * 0.013,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Specifications',
              style: GoogleFonts.aBeeZee().copyWith(fontSize: 20),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSpec('color', _selectedCar.color, size.height),
                _buildSpec('GearBox', _selectedCar.gearBox, size.height),
                _buildSpec('Seats', _selectedCar.seat.toString(), size.height),
                _buildSpec(
                    'fuel cons.', _selectedCar.fuelConsumption, size.height)
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(5),
          height: size.height * 0.09,
          decoration: BoxDecoration(
            color: Colors.white10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_month,
                      style: GoogleFonts.aBeeZee().copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  Row(
                    children: [
                      Text('USD $_price',
                          style: GoogleFonts.aBeeZee().copyWith(
                            fontSize: 18,
                          )),
                      Text(
                        ' / per month',
                        style: GoogleFonts.aBeeZee().copyWith(
                            fontSize: 12,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  print('Thanks SHema');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.065,
                  width: size.height * 0.171,
                  child: Text('Book',
                      style: GoogleFonts.aBeeZee().copyWith(
                        fontSize: 18,
                        color: Colors.white,
                      )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                    color: Colors.brown,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpec(String name, String password, double size) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: size * 0.13,
      width: size * 0.19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            name,
            style: GoogleFonts.aBeeZee().copyWith(
              fontSize: 13,
            ),
          ),
          Text(
            password,
            style: GoogleFonts.aBeeZee().copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard(
      double height, double width, String month, String price, int select) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _select = select;
          _month = month;
          _price = price;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: select == _select ? Colors.brown[300] : Colors.white54,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(month,
                style: GoogleFonts.aBeeZee().copyWith(
                    fontSize: 18,
                    color: select == _select ? Colors.white : Colors.black54)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  price,
                  style: GoogleFonts.aBeeZee().copyWith(
                      fontSize: 25,
                      color: select == _select ? Colors.white : Colors.black54),
                ),
                Text('USD',
                    style: GoogleFonts.aBeeZee().copyWith(
                        fontSize: 13,
                        color:
                            select == _select ? Colors.white : Colors.black54))
              ],
            )
          ],
        ),
      ),
    );
  }
}
