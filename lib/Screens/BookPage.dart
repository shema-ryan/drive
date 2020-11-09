import 'dart:async';
import 'package:drive/Screens/screens.dart';
import 'package:drive/model/Api.dart';
import 'package:drive/model/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math' show cos, sqrt, asin;

class BookPage extends StatefulWidget {
  static const String routeName = '/BookPage';
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  PolylinePoints polylinePoints = PolylinePoints();
  double total = 0.0;
  List<LatLng> polylineCoordinates = [];
  GoogleMapController _googleMapController;
  Set<Polyline> _polyLine = {};
  Position _position = Position(latitude: 0.0, longitude: 0.0);
  final Position _destination = Position(
    latitude: 37.4220,
    longitude: -122.085,
  );
  Future<void> _createPolyLines(Position start, Position destination) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Api.api, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    double _coordinateDistance(lat1, lon1, lat2, lon2) {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    double totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    setState(() {
      _polyLine.add(Polyline(
        polylineId: PolylineId('id1'),
        color: Colors.red,
        endCap: Cap.roundCap,
        startCap: Cap.buttCap,
        points: polylineCoordinates,
        width: 3,
        visible: true,
      ));
      total = totalDistance;
    });
  }

  void _updateCameraView() {
    Position _northEastPosition;
    Position _southWestPosition;
    if (_position.latitude <= _destination.latitude) {
      _northEastPosition = _destination;
      _southWestPosition = _position;
    } else {
      _northEastPosition = _position;
      _southWestPosition = _destination;
    }

    _googleMapController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast:
              LatLng(_northEastPosition.latitude, _northEastPosition.longitude),
          southwest:
              LatLng(_southWestPosition.latitude, _southWestPosition.longitude),
        ),
        10));
  }

  DateTime _selected;
  TimeOfDay _selectedTime;
  Future<void> _getCurrentLocation() async {
    Position location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _position = location;
    setState(() {
      _googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_position.latitude, _position.longitude),
        zoom: 15.0,
      )));
    });
    await _createPolyLines(_position, _destination);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 0)).then((value) {
      _getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Map<String, dynamic> select =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    Car _selectedCar = select['selected'];
    String _price = select['price'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            child: GoogleMap(
              polylines: _polyLine,
              onMapCreated: (GoogleMapController controller) {
                _googleMapController = controller;
              },
              initialCameraPosition:
                  CameraPosition(target: LatLng(0.0, 0.0), zoom: 18.0),
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              mapType: MapType.normal,
              markers: {
                Marker(
                  markerId: MarkerId('start'),
                  infoWindow: InfoWindow(
                      title: 'Here you are.',
                      snippet: 'this look like your current location'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(_position.latitude, _position.longitude),
                ),
                Marker(
                  markerId: MarkerId('dest'),
                  infoWindow: InfoWindow(
                      title: 'Car location', snippet: 'am waiting for you'),
                  icon: BitmapDescriptor.defaultMarker,
                  position:
                      LatLng(_destination.latitude, _destination.longitude),
                ),
              },
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  right: 5,
                  child: Column(
                    children: [
                      RawMaterialButton(
                        fillColor: Colors.brown[100],
                        elevation: 2.0,
                        shape: CircleBorder(),
                        onPressed: () {
                          _googleMapController
                              .animateCamera(CameraUpdate.zoomIn());
                        },
                        child: Icon(Icons.add),
                      ),
                      RawMaterialButton(
                        fillColor: Colors.brown[100],
                        elevation: 2.0,
                        shape: CircleBorder(),
                        onPressed: () {
                          print('this are the polyines :$_polyLine');
                          _googleMapController
                              .animateCamera(CameraUpdate.zoomOut());
                        },
                        child: Icon(Icons.remove),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.brown,
                    icon: Icon(Icons.arrow_back_rounded),
                  ),
                ),
                Positioned(
                  top: 35,
                  right: 100,
                  child: Text('Distance : ' + total.toStringAsFixed(3) + 'km'),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 220,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0)),
                      color: Colors.brown[300],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '\$' + _price,
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  'price / month',
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.056,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedCar.brand,
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
                                  _selectedCar.model,
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
                                  _selectedCar.fuelConsumption ?? 'shem',
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
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'shema',
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  'Owner',
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
                                  '0703911701',
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  'Contact',
                                  style: GoogleFonts.aBeeZee().copyWith(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              ],
                            ),
                            RaisedButton(
                              color: Colors.brown,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  firstDate: DateTime.now(),
                                ).then((pickedDate) {
                                  if (pickedDate == null) {
                                    return null;
                                  }
                                  _selected = pickedDate;
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      _selectedTime = value;
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              StartPage.routeName);
                                    }
                                  });
                                });
                              },
                              child: Text(
                                'Rent',
                                style: GoogleFonts.aBeeZee().copyWith(
                                    fontSize: 15, color: Colors.white70),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 1,
                  bottom: 150,
                  child: Image.asset(
                    _selectedCar.images[0],
                    height: size.height * 0.16,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
