import 'package:drive/model/bookingCar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecentBookings extends StatelessWidget {
  static final String routeName = '/recentBookings';
  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser.email;
    final ordered = Provider.of<OrderCar>(context, listen: true).getOrders;
    final List<Order> _myOrder =
        ordered.where((element) => element.email == email).toList();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'Recent Bookings',
          style: GoogleFonts.aBeeZee().copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: _myOrder.length == 0
          ? Center(
              child: Text(
                'you haven\'t booked any car',
                style: GoogleFonts.aBeeZee().copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              itemCount: _myOrder.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\$' + '${_myOrder[index].amount}',
                              style: GoogleFonts.aBeeZee()
                                  .copyWith(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              'price to be paid for',
                              style: GoogleFonts.aBeeZee().copyWith(
                                  fontSize: 15, color: Colors.white70),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _myOrder[index].car.brand,
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 18, color: Colors.white),
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
                                  _myOrder[index].car.model,
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 18, color: Colors.white),
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
                                  _myOrder[index].car.fuelConsumption ?? 'shem',
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 18, color: Colors.white),
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
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('Booking Terms',
                            style: GoogleFonts.aBeeZee()
                                .copyWith(fontSize: 18, color: Colors.white)),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _myOrder[index].startDate,
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'Start-date',
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
                                  _myOrder[index].returnDate,
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'returnDate',
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
                                  _myOrder[index].date,
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'paid for',
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Text(
                          'Booking Id : ${_myOrder[index].id}',
                          style: GoogleFonts.aBeeZee().copyWith(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _myOrder[index].name,
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'name',
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
                                  _myOrder[index].location,
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'Location',
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
                                  _myOrder[index].ninNumber.toString(),
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'NinNumber',
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ));
              },
            ),
    );
  }
}
