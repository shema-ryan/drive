import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drive/model/model.dart';
import './screens.dart';
import 'package:provider/provider.dart';

class BookingPage extends StatefulWidget {
  static String routeName = '/BookingPage';
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _auth = FirebaseAuth.instance;
  int _currentStep = 0;
  bool _complete1 = false;
  bool _complete2 = false;
  bool _complete3 = false;
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  String selected;
  int total;
  String start;
  String end;
  String ninNumber;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OrderCar _car = Provider.of<OrderCar>(context, listen: false);
    final Car selectedCar = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Booking Page',
        ),
        centerTitle: true,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepCancel: () {
          if (_currentStep == 0) {
            return null;
          } else {
            setState(() {
              _currentStep--;
            });
          }
        },
        onStepContinue: () {
          if (_currentStep == 2) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Booking Status'),
                      content: Text(
                        'Done',
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        FlatButton(
                          child: Text(
                            'ok',
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            _car.addOrder(Order(
                              car: selectedCar,
                              email: _auth.currentUser.email,
                              name: _controller1.text,
                              amount: total,
                              startDate: start,
                              returnDate: end,
                              contact: _controller2.text,
                              location: _controller3.text,
                              date: selected,
                              ninNumber: _controller4.text,
                              id: '0RM/R/-${Random().nextInt(194560).toString()}-BUGEMA',
                            ));
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    )).then((value) {
              Navigator.of(context).pushNamed(FirstScreen.routeName);
            });
            return;
          }
          setState(() {
            if (_currentStep == 0) {
              _complete1 = true;
              _currentStep++;
            } else if (_currentStep >= 1) {
              _complete2 = true;
              _currentStep++;
            } else {
              _complete3 = true;
              _currentStep++;
            }
          });
        },
        onStepTapped: (int) {
          setState(() {
            _currentStep = int;
            print(int);
          });
        },
        steps: [
          Step(
            isActive: true,
            state: _complete1 ? StepState.complete : StepState.editing,
            title: Text(
              'Booking person info',
              style: GoogleFonts.aBeeZee().copyWith(
                  color: Theme.of(context).primaryColor, fontSize: 18),
            ),
            content: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'full name',
                  ),
                  controller: _controller1,
                ),
                TextField(
                  controller: _controller2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                  ),
                ),
                TextField(
                  controller: _controller4,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'NIN number',
                  ),
                )
              ],
            ),
          ),
          Step(
            state: _complete2 ? StepState.complete : StepState.editing,
            isActive: _complete1,
            title: Text(
              'Address',
              style: GoogleFonts.aBeeZee()
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            content: Column(
              children: [
                TextField(
                  controller: _controller3,
                  decoration: InputDecoration(hintText: 'your location'),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selected == null ? 'select range for hire' : selected),
                    IconButton(
                      onPressed: () {
                        showDateRangePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 2),
                        ).then((value) {
                          start =
                              '${value.start.day}\ -${value.start.month}\ -${value.start.year}';
                          end =
                              '${value.end.day}\ -${value.end.month}\ -${value.end.year}';
                          setState(() {
                            selected = '${value.duration.inDays}  days';
                            total = int.parse('${value.duration.inDays}') * 140;
                          });
                        });
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Step(
              isActive: _complete2,
              state: _complete3 ? StepState.complete : StepState.editing,
              title: Text(
                'payment info',
                style: GoogleFonts.aBeeZee()
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              content: Column(
                children: [
                  Text(total == null
                      ? 'please check the range'
                      : 'Use Mobile Money to send $total  \$ to 0703911701 and Keep the Transaction message')
                ],
              )),
        ],
      ),
    );
  }
}
