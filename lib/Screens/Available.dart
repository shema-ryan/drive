import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/model.dart';
import 'package:provider/provider.dart';

class AvailableCars extends StatelessWidget {
  static const String routeName = '/Available';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<Car> _loaded = Provider.of<Data>(context).listCars;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Available Cars',
          style: GoogleFonts.aBeeZee()
              .copyWith(fontSize: 20, color: Theme.of(context).primaryColor),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: _loaded.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '\$' + '${_loaded[index].price}',
                            style: GoogleFonts.aBeeZee()
                                .copyWith(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            'price /' + _loaded[index].condition,
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
                                _loaded[index].brand,
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
                                _loaded[index].model,
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
                                _loaded[index].fuelConsumption ?? 'shem',
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
                  _loaded[index].images[0],
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
