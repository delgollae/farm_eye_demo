import 'dart:async';

import 'package:farm_eye_app/pages/location_tracking/map_widgets/map_location_detail_widget.dart';
import 'package:farm_eye_app/pages/widgets/app_page_container.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'profile_page.dart';
import 'sample_collect_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class FarmEyeOsmMapPathDrawPage extends StatefulWidget {
  const FarmEyeOsmMapPathDrawPage({Key? key}) : super(key: key);

  @override
  _FarmEyeOsmMapPathDrawPageState createState() =>
      _FarmEyeOsmMapPathDrawPageState();
}

class _FarmEyeOsmMapPathDrawPageState extends State<FarmEyeOsmMapPathDrawPage> {
  late MapController mapController;
  late RoadInfo roadInfo;
  late List<dynamic> waysPoint = [];
  late Position startLocation;
  late Position currentLocation = Position(
      longitude: 7.225392645477078,
      latitude: 80.19738065353602,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1);
  late List<GeoPoint> intersectPoint;
  late GlobalKey<ScaffoldState> scaffoldKey;
  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> visibilityZoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> advPickerNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);

  Stopwatch watch = Stopwatch();
  late Timer timer;
  bool startStop = true;

  String elapsedTime = '';

//msg:"startstop Inside=$startLocation ",
  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        // Fluttertoast.showToast(
        //     msg:"Start > Lat : ${startLocation.latitude}  Lon : ${startLocation.longitude} Stop > ${currentLocation.latitude}  Lon : ${currentLocation.longitude}",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
        getUserLocation();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    locateUser();
    mapController = MapController(
        initMapWithUserPosition: false,
        initPosition: GeoPoint(
          latitude: 53.084344,
          longitude: -7.917130,
        ));

    scaffoldKey = GlobalKey<ScaffoldState>();
    mapController.listenerMapLongTapping.addListener(() {
      if (mapController.listenerMapLongTapping.value != null) {
        print(mapController.listenerMapLongTapping.value);
      }
    });
    mapController.listenerMapSingleTapping.addListener(() {
      if (mapController.listenerMapSingleTapping.value != null) {
        print(mapController.listenerMapSingleTapping.value);
      }
    });

    Future.delayed(Duration(minutes: 5), () async {
      //await mapController.removeLimitAreaMap();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      mapController = MapController(
          initMapWithUserPosition: true,
          initPosition: GeoPoint(
            latitude: position.latitude,
            longitude: position.longitude,
          ));
    });
    Future.delayed(Duration(minutes: 5), () async {
      //await mapController.removeLimitAreaMap();
      await mapController.myLocation();
    });
    Future.delayed(Duration(seconds: 5), () async {
      await mapController.zoomIn();
    });
    Future.delayed(Duration(seconds: 10), () async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      await mapController.changeLocation(
        GeoPoint(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    });

    Future.delayed(Duration(seconds: 10), () async {
      await mapController.setMarkerOfStaticPoint(
        id: "line 2",
        markerIcon: MarkerIcon(
          icon: Icon(
            Icons.accessibility_new,
            color: Colors.red,
            size: 75,
          ),
        ),
      );
      Future.delayed(Duration(seconds: 5), () async {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        await mapController.changeLocation(
          GeoPoint(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        );

        getUserLocation();
        // RoadInfo roadInfo = await mapController.drawRoad(
        //   GeoPoint(latitude: 53.084344, longitude: -7.917130),
        //   GeoPoint(latitude: 53.017750, longitude: -8.034510),
        //   roadType: RoadType.car,
        //   roadOption: RoadOption(
        //     roadColor: Colors.blue,
        //     roadWidth: 10,
        //     showMarkerOfPOI: false,
        //     zoomInto: true
        //   ),
        //   intersectPoint : [
        //     GeoPoint(latitude: 53.084344, longitude: -7.917130),
        //     GeoPoint(latitude: 53.102560, longitude: -8.002857),
        //     GeoPoint(latitude: 53.098600, longitude: -8.163759),
        //     GeoPoint(latitude: 53.070082, longitude: -8.147933),
        //     GeoPoint(latitude: 53.021717, longitude: -8.129468),
        //     GeoPoint(latitude: 53.045510, longitude: -8.109685),
        //     GeoPoint(latitude: 53.017750, longitude: -8.034510),
        //   ]
        // );
        // print("${roadInfo.distance}km");
        // print("${roadInfo.duration}sec");

        // await showSimplePickerLocation(
        //   context: context,
        //   isDismissible: true,
        //   title: "Journey ${roadInfo.distance} km" + " " + "${roadInfo.duration} sec",
        //   textConfirmPicker: "pick",
        //   initCurrentUserPosition: true,
        // );
      });
    });
  }

  Future<Position> locateUser() async {
    currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    /*Fluttertoast.showToast(
        msg:"Lat : ${currentLocation.latitude}  Lon : ${currentLocation.longitude}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );*/

    //7.052019, 79.930041
    //7.051550, 79.932917
    RoadInfo roadInfo = await mapController.drawRoad(
        GeoPoint(
            latitude: startLocation.latitude,
            longitude: startLocation.longitude),
        GeoPoint(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude),
        roadType: RoadType.car,
        roadOption: RoadOption(
            roadColor: Colors.blue,
            roadWidth: 10,
            showMarkerOfPOI: true,
            zoomInto: true),
        intersectPoint: [
          GeoPoint(
              latitude: startLocation.latitude,
              longitude: startLocation.longitude),
          GeoPoint(
              latitude: currentLocation.latitude,
              longitude: currentLocation.longitude),
        ]);
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPageContainer(
        appBarWidget: AppBar(title: Text("Map Path Tracking")),
        showAppBar: true,
        body: Stack(
          children: [
            Container(
              // height: 1000,
              child: OrientationBuilder(builder: (ctx, orientation) {
                return
                    // Container(
                    //   child: Stack(
                    //       children: [

                    OSMFlutter(
                  controller: mapController,
                  trackMyPosition: false,
                  initZoom: 12,
                  minZoomLevel: 8,
                  maxZoomLevel: 14,
                  stepZoom: 1.0,
                  userLocationMarker: UserLocationMaker(
                    personMarker: MarkerIcon(
                      icon: Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: 48,
                      ),
                    ),
                    directionArrowMarker: MarkerIcon(
                      icon: Icon(
                        Icons.double_arrow,
                        size: 48,
                      ),
                    ),
                  ),
                  roadConfiguration: RoadConfiguration(
                    startIcon: MarkerIcon(
                      icon: Icon(
                        Icons.person,
                        size: 64,
                        color: Colors.brown,
                      ),
                    ),
                    roadColor: Colors.yellowAccent,
                  ),
                  markerOption: MarkerOption(
                      defaultMarker: MarkerIcon(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 56,
                    ),
                  )),
                );
                //         ]
                //     )
                // );
              }),
            ),
            Positioned(
              top: 30,
              right: 10,
              child: MapLocationDetailWidget(
                  latitude: currentLocation.latitude.toString(),
                  longitude: currentLocation.latitude.toString()),
              // child: Container(
              //   height: MediaQuery.of(context).size.width * 0.5,
              //   width: MediaQuery.of(context).size.width * 0.5,
              //   color: Colors.pink,
              // )
            ),
          ],
        ),
        floatingActionButton: _popupMenu());
  }

  Widget _popupMenu() {
    return SpeedDial(
      child: const Icon(Icons.menu),
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
          child: const Icon(Icons.play_circle_fill_outlined),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          onPressed: () {
            Fluttertoast.showToast(
                msg: "GPS Recording Started",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            startWatch();
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.stop_circle),
          foregroundColor: Colors.black,
          backgroundColor: Colors.yellow,
          onPressed: () {
            Fluttertoast.showToast(
                msg: "GPS Recording Stopped",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            stopWatch();
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.list_alt_rounded),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          onPressed: () {
            Fluttertoast.showToast(
                msg: "View GPS Cordinates",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          },
        ),
      ],
      closedForegroundColor: Colors.black,
      openForegroundColor: Colors.white,
      closedBackgroundColor: Colors.white,
      openBackgroundColor: Colors.black,
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    setState(() {
      startLocation = currentLocation;
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 10000), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}
