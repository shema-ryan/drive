import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/model.dart';

class AvailableCars extends StatelessWidget {
  static const String routeName = '/Available';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
          'Available Cars',
          style: GoogleFonts.aBeeZee()
              .copyWith(fontSize: 20, color: Color(0xFF71482A)),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: Data.getCarList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFFDE925C),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '\$' + '${Data.getCarList[index].price}',
                            style: GoogleFonts.aBeeZee()
                                .copyWith(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            'price /' + Data.getCarList[index].condition,
                            style: GoogleFonts.aBeeZee()
                                .copyWith(fontSize: 15, color: Colors.white70),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.066,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                Data.getCarList[index].brand,
                                style: GoogleFonts.aBeeZee().copyWith(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                'Brand',
                                style: GoogleFonts.aBeeZee().copyWith(
                                    fontSize: 15, color: Colors.white70),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                Data.getCarList[index].model,
                                style: GoogleFonts.aBeeZee().copyWith(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                'Model',
                                style: GoogleFonts.aBeeZee().copyWith(
                                    fontSize: 15, color: Colors.white70),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                Data.getCarList[index].fuelConsumption ??
                                    'shem',
                                style: GoogleFonts.aBeeZee().copyWith(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                'fuel cons.',
                                style: GoogleFonts.aBeeZee().copyWith(
                                    fontSize: 15, color: Colors.white70),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )),
              Positioned(
                right: 10,
                top: -5,
                child: Image.asset(
                  Data.getCarList[index].images[0],
                  height: size.height * 0.13,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
