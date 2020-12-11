import 'dart:async';
import 'package:drive/Screens/Booking_page.dart';
import 'package:drive/model/model.dart';
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
  Marker marker;

  Position _position = Position(latitude: 0.0, longitude: 0.0);
  final Position _destination = Position(
    latitude: 37.4220,
    longitude: -122.085,
  );

  //function to handler large png on map
  // Future<Uint8List> getBytesFromAsset() async {
  //   ByteData data = await rootBundle.load('assets/images/car.png');
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: 50);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
  //       .buffer
  //       .asUint8List();
  // }

  Future<void> _createPolyLines(Position start, Position destination) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Api.api, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
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
        color: Theme.of(context).primaryColor,
        endCap: Cap.roundCap,
        startCap: Cap.buttCap,
        points: polylineCoordinates,
        width: 3,
        visible: true,
      ));
      total = totalDistance;
    });
  }

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
    Future.delayed(Duration(microseconds: 0)).then((value) async {
      await _getCurrentLocation();
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
              cameraTargetBounds: CameraTargetBounds(LatLngBounds(
                northeast: _position.latitude <= _destination.latitude
                    ? LatLng(_destination.latitude, _destination.longitude)
                    : LatLng(_position.latitude, _position.longitude),
                southwest: _position.latitude <= _destination.latitude
                    ? LatLng(_position.latitude, _position.longitude)
                    : LatLng(_destination.latitude, _destination.longitude),
              )),
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
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange),
                  position: LatLng(_position.latitude, _position.longitude),
                ),
                Marker(
                  markerId: MarkerId('dest'),
                  infoWindow: InfoWindow(
                      title: 'Car location', snippet: 'am waiting for you'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure),
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
                  top: size.height * 0.06,
                  right: size.height * 0.006,
                  child: Column(
                    children: [
                      RawMaterialButton(
                        fillColor: Theme.of(context).primaryColor,
                        elevation: 2.0,
                        shape: CircleBorder(),
                        onPressed: () {
                          _googleMapController
                              .animateCamera(CameraUpdate.zoomIn());
                          print(marker);
                        },
                        child: Icon(Icons.add),
                      ),
                      RawMaterialButton(
                        fillColor: Theme.of(context).primaryColor,
                        elevation: 2.0,
                        shape: CircleBorder(),
                        onPressed: () async {
                          _googleMapController
                              .animateCamera(CameraUpdate.zoomOut());
                        },
                        child: Icon(Icons.remove),
                      ),
                      SizedBox(
                        height: size.height * 0.013,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: size.height * 0.026,
                  left: size.height * 0.013,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).primaryColor,
                    icon: Icon(Icons.arrow_back_rounded),
                  ),
                ),
                Positioned(
                  top: size.height * 0.046,
                  right: size.height * 0.13,
                  child: Text('Distance : ' + total.toStringAsFixed(3) + 'km'),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: size.height * 0.29,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0)),
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
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
                              width: size.height * 0.013,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.046,
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
                          height: size.height * 0.026,
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
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    BookingPage.routeName,
                                    arguments: _selectedCar);
                              },
                              child: Text(
                                'Book',
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
                  bottom: size.height * 0.20,
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
