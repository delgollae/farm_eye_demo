import 'dart:async';

import 'package:farm_eye_app/pages/widgets/app_page_container.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'profile_page.dart';
import 'sample_collect_page.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class FarmEyeMapPathPage extends StatefulWidget {
  const FarmEyeMapPathPage({Key? key}) : super(key: key);

  @override
  _FarmEyeMapPathPageState createState() => _FarmEyeMapPathPageState();
}

class _FarmEyeMapPathPageState extends State<FarmEyeMapPathPage> {
  // final Completer<GoogleMapController> _controller = Completer();

  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyBFKsCFDsWD3eyal8cDM6SE1E63GbaFW9c";

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(53.144751, -7.850996);
  LatLng endLocation = LatLng(53.151525, -7.568105);


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
    markers.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    getDirections(); //fetch direction polylines from Google API


    super.initState();
    setState(() {
      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPageContainer(
      showAppBar: false,
      /*body: Stack(
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
      ),*/
      body: GoogleMap( //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition( //innital position in map
          target: startLocation, //initial position
          zoom: 16.0, //initial zoom level
        ),
        markers: markers, //markers to show on map
        polylines: Set<Polyline>.of(polylines.values), //polylines
        mapType: MapType.normal, //map type
        onMapCreated: (controller) { //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
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

          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.wrap_text_sharp),
          foregroundColor: Colors.black,
          backgroundColor: Colors.yellow,
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


  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }


}
