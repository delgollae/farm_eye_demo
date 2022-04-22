import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';


import 'package:farm_eye_app/pages/widgets/app_page_container.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'profile_page.dart';
import 'sample_collect_page.dart';

class FarmEyeOsmMapLocationsPage extends StatefulWidget {
  const FarmEyeOsmMapLocationsPage({Key? key}) : super(key: key);

  @override
  _FarmEyeOsmMapLocationsPageState createState() => _FarmEyeOsmMapLocationsPageState();
}

class _FarmEyeOsmMapLocationsPageState extends State<FarmEyeOsmMapLocationsPage> {
  late MapController mapController;
  late GlobalKey<ScaffoldState> scaffoldKey;
  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> visibilityZoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> advPickerNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    mapController = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
        latitude: 53.084344,
        longitude: -7.917130,
      )
    );
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
    });
    Future.delayed(Duration(seconds: 5), () async {
      await mapController.zoomIn();
    });
    Future.delayed(Duration(seconds: 15), () async {
      await mapController.changeLocation(
        GeoPoint(
          latitude: 53.102560,
          longitude: -8.002857,
        ),
      );
      await mapController.drawCircle(
        CircleOSM(
          key: "circle1",
          centerPoint: GeoPoint(
            latitude: 53.098600,
            longitude: -8.163759,
          ),
          radius: 4000.0,
          color: Colors.purple,
          strokeWidth: 0.7,
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
        ///53.084344, -7.917130
        ///53.102560, -8.002857
        ///53.098600, -8.163759
        ///53.070082, -8.147933
        ///53.021717, -8.129468
        ///53.045510, -8.109685
        ///53.017750, -8.034510
        RoadInfo roadInfo = await mapController.drawRoad(
          GeoPoint(latitude: 53.084344, longitude: -7.917130),
          GeoPoint(latitude: 53.017750, longitude: -8.034510),
          roadType: RoadType.car,
          roadOption: RoadOption(
            roadColor: Colors.blue,
            roadWidth: 10,
            showMarkerOfPOI: false,
            zoomInto: true
          ),
          intersectPoint : [
            GeoPoint(latitude: 53.084344, longitude: -7.917130),
            GeoPoint(latitude: 53.102560, longitude: -8.002857),
            GeoPoint(latitude: 53.098600, longitude: -8.163759),
            GeoPoint(latitude: 53.070082, longitude: -8.147933),
            GeoPoint(latitude: 53.021717, longitude: -8.129468),
            GeoPoint(latitude: 53.045510, longitude: -8.109685),
            GeoPoint(latitude: 53.017750, longitude: -8.034510),
          ]
        );
        print("${roadInfo.distance}km");
        print("${roadInfo.duration}sec");

        await showSimplePickerLocation(
          context: context,
          isDismissible: true,
          title: "Journey ${roadInfo.distance} km" + " " + "${roadInfo.duration} sec",
          textConfirmPicker: "pick",
          initCurrentUserPosition: true,
        );
      });

      /// to draw
      //7.031775,79.928571
      //7.011876, 79.966560
      //6.991820, 79.941110
      //6.968159, 79.903876
      await mapController.drawCircle(CircleOSM(
        key: "circle0",
        centerPoint: GeoPoint(latitude: 53.017750, longitude: -8.034510),
        radius: 3200.0,
        color: Colors.red,
        strokeWidth: 0.9,
      ));
      /// to remove Circle using Key
      await mapController.removeCircle("circle0");

      /// to remove All Circle in the map
      await mapController.removeAllCircle();


      ///================
      /// to draw
      await mapController.drawRect(RectOSM(
        key: "rect",
        centerPoint: GeoPoint(latitude: 53.084344, longitude: -7.917130),
        distance: 200.0,
        color: Colors.deepOrange,
        strokeWidth: 0.3,
      ));
      /// to remove Rect using Key
      await mapController.removeRect("rect");

      /// to remove All Rect in the map
      await mapController.removeAllRect();


      ///**************

      ///53.084344, -7.917130
      ///53.102560, -8.002857
      ///53.098600, -8.163759
      ///53.070082, -8.147933
      ///53.021717, -8.129468
      ///53.045510, -8.109685
      ///53.017750, -8.034510
      await mapController.setStaticPosition(
        [
          GeoPointWithOrientation(
            latitude: 53.084344,
            longitude: -7.917130,
            angle: pi / 4,
          ),
          GeoPointWithOrientation(
            latitude: 53.017750,
            longitude: -8.034510,
            angle: pi / 2,
          ),
        ],
        "line 2",
      );
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrientationBuilder(
          builder: (ctx, orientation) {
            return Container(
                child: Stack(
                    children: [
                  OSMFlutter(
                    controller:mapController,
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
                        )
                    ),
                  ),
                      ]
                )
            );
          }
        ),
        floatingActionButton: _popupMenu()
    );
  }


  Widget _popupMenu(){
    return SpeedDial(
      child: const Icon(Icons.menu),
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
          child: const Icon(Icons.play_circle_fill_outlined),
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
          child: const Icon(Icons.stop_circle),
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
          child: const Icon(Icons.list_alt_rounded),
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

}
