import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookPage extends StatefulWidget {
  static const String routeName = 'nevermind';
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  GoogleMapController _googleMapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _googleMapController = controller;
              },
              initialCameraPosition: _kGooglePlex,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              mapType: MapType.normal,
            ),
            Positioned(
              top: size.height / 2 - 50,
              right: 5,
              child: Column(
                children: [
                  RawMaterialButton(
                    fillColor: Colors.brown[100],
                    elevation: 2.0,
                    shape: CircleBorder(),
                    onPressed: () {
                      _googleMapController.animateCamera(CameraUpdate.zoomIn());
                    },
                    child: Icon(Icons.add),
                  ),
                  RawMaterialButton(
                    fillColor: Colors.brown[100],
                    elevation: 2.0,
                    shape: CircleBorder(),
                    onPressed: () {
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
          ],
        ),
      ),
    );
  }
}
