import 'dart:async';
import 'package:farm_eye_app/models/pin_information.dart';
import 'package:farm_eye_app/pages/widgets/app_page_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

const LatLng SOURCE_LOCATION = LatLng(7.222372064497692, 80.19088610049356);
const LatLng DEST_LOCATION = LatLng(7.225392645477078, 80.19738065353602);
class FarmEyeOsmLocationTracking extends StatefulWidget {
  const FarmEyeOsmLocationTracking({Key? key}) : super(key: key);

  @override
  _FarmEyeOsmLocationTrackingState createState() => _FarmEyeOsmLocationTrackingState();
}


class _FarmEyeOsmLocationTrackingState extends State<FarmEyeOsmLocationTracking> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  String googleAPIKey = "AIzaSyBFKsCFDsWD3eyal8cDM6SE1E63GbaFW9c";
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;
  LocationData? currentLocation;
  LocationData? destinationLocation;
  Location? location;
  double pinPillPosition = -100;
  int polyId = 1;
  PinInformation? currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation? sourcePinInfo;
  PinInformation? destinationPinInfo;
  @override
  void initState() {
    super.initState();
    location = new Location();
    setInitialLocation();
    polylinePoints = PolylinePoints();
    location!.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
      updatePinOnMap();
      setPolylines();
    });
    setSourceAndDestinationIcons();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0), 'assets/images/driving_pin.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/square_pin.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void setInitialLocation() async {
    currentLocation = await location!.getLocation();
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
  }
  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = const CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return AppPageContainer(
        showAppBar: false,
      body: Stack(
        children: [
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onTap: (LatLng loc) {
              },
              onMapCreated: (GoogleMapController controller) {
                // controller.setMapStyle(Utils.mapStyles);
                _controller.complete(controller);
                print("map opened");
                showPinsOnMap();
              }),
          // MapPinPillComponent(
          //     pinPillPosition: pinPillPosition,
          //     currentlySelectedPin: currentlySelectedPin)
        ],
      ),
    );
  }

  void showPinsOnMap() {
    if (currentLocation != null && destinationLocation != null) {
      var pinPosition =
      LatLng(currentLocation!.latitude??0, currentLocation!.longitude??0);
      // print("pinPosition >> $pinPosition");
      var destPosition =
      LatLng(destinationLocation!.latitude??0, destinationLocation!.longitude??0);

      sourcePinInfo = PinInformation(
          locationName: "Start Location",
          location: SOURCE_LOCATION,
          pinPath: "assets/images/driving_pin.png",
          avatarPath: "assets/images/square_pin.png",
          labelColor: Colors.blueAccent);

      destinationPinInfo = PinInformation(
          locationName: "End Location",
          location: DEST_LOCATION,
          pinPath: "assets/images/destination_map_marker.png",
          avatarPath: "assets/images/square_pin.png",
          labelColor: Colors.purple);

      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition,
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          icon:  BitmapDescriptor.defaultMarker));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: destPosition,
          onTap: () {
            setState(() {
              currentlySelectedPin = destinationPinInfo;
              pinPillPosition = 0;
            });
          },
          icon:  BitmapDescriptor.defaultMarker));
      setPolylines();
    }
  }


  void setPolylines() async {
   PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(currentLocation!.latitude!,currentLocation!.longitude!),
       PointLatLng( destinationLocation!.latitude!, destinationLocation!.longitude!),
       );
List<PointLatLng>points =result.points;
    if (points.isNotEmpty) {
      points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      final String polylineIdVal = 'polyline_id_$polyId';
      polyId++;
      final PolylineId polylineId = PolylineId(polylineIdVal);
      _polylines = new Set<Polyline>();
      setState(() {
        _polylines.add( Polyline(
            width: 6,
            // set the width of the polylines
            polylineId: polylineId,
            geodesic: true,
            consumeTapEvents: true,
            color: Colors.blue,
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap() async {
    if (currentLocation != null && destinationLocation != null) {
      var pinPosition =
      LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      // print("pinPosition >> $pinPosition");
      var destPosition =
      LatLng(destinationLocation!.latitude!, destinationLocation!.longitude!);

      sourcePinInfo = PinInformation(
          locationName: "Start Location",
          location: SOURCE_LOCATION,
          pinPath: "assets/driving_pin.png",
          avatarPath: "assets/square_pin.png",
          labelColor: Colors.blueAccent);

      destinationPinInfo = PinInformation(
          locationName: "End Location",
          location: DEST_LOCATION,
          pinPath: "assets/destination_map_marker.png",
          avatarPath: "assets/square_pin.png",
          labelColor: Colors.purple);

      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition,
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          icon: BitmapDescriptor.defaultMarker));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: destPosition,
          onTap: () {
            setState(() {
              currentlySelectedPin = destinationPinInfo;
              pinPillPosition = 0;
            });
          },
          icon:  BitmapDescriptor.defaultMarker));

      CameraPosition cPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
      setState(() {
        // print("pinPosition lat " + currentLocation.latitude.toString()+"  long "+ currentLocation.longitude.toString());
        var pinPosition =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
        sourcePinInfo!.location = pinPosition;
        _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
        _markers.add(Marker(
            markerId: MarkerId('sourcePin'),
            onTap: () {
              setState(() {
                currentlySelectedPin = sourcePinInfo;
                pinPillPosition = 0;
              });
            },
            position: pinPosition, // updated position
            icon:  BitmapDescriptor.defaultMarker));
      });
    }
  }
}