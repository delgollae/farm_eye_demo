import 'dart:async';

import 'package:farm_eye_app/pages/widgets/app_page_container.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'profile_page.dart';
import 'sample_collect_page.dart';

class FarmEyeMapPage extends StatefulWidget {
  const FarmEyeMapPage({Key? key}) : super(key: key);

  @override
  _FarmEyeMapPageState createState() => _FarmEyeMapPageState();
}

class _FarmEyeMapPageState extends State<FarmEyeMapPage> {
  // final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPageContainer(
      showAppBar: false,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            child: Container(
              child: Column(
                children: [Text("Latitude"), Text("Longitude")],
              ),
            ),
          ),
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            markers: _markers,
          ),
        ],
      ),
      floatingActionButton: _popupMenu(),
    );
  }

  void getLocation() async {
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _controller
          ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      print(loc.latitude);
      print(loc.longitude);
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
      });
    });
  }

  Widget _popupMenu(){
   return SpeedDial(
      child: const Icon(Icons.menu),
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
          child: const Icon(Icons.agriculture),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => ProfilePage()
                ),
                    (Route<dynamic> route) => false
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.wrap_text_sharp),
          foregroundColor: Colors.black,
          backgroundColor: Colors.yellow,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => SampleCollectPage()
                ),
                    (Route<dynamic> route) => false
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.local_police_sharp),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => SampleCollectPage()
                ),
                    (Route<dynamic> route) => false
            );
          },
        ),
      ],
      closedForegroundColor: Colors.black,
      openForegroundColor: Colors.white,
      closedBackgroundColor: Colors.white,
      openBackgroundColor: Colors.black,
    );
  }

  Widget _offsetPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () {},
            value: 1,
            child: const Text(
              "Flutter Open",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          PopupMenuItem(
            onTap: () {},
            value: 2,
            child: const Text(
              "Flutter Tutorial",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        icon: Icon(Icons.menu),
      );
}
