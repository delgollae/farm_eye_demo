
import 'package:farm_eye_app/pages/farm_eye_map_page.dart';
import 'package:farm_eye_app/pages/farm_eye_osm_location_tracking.dart';
import 'package:farm_eye_app/pages/home/home_page.dart';
import 'package:farm_eye_app/pages/splash_screen.dart';
import 'package:farm_eye_app/pages/sample_collect_page.dart';
import 'package:farm_eye_app/pages/farm_eye_map_path_page.dart';
import 'package:farm_eye_app/pages/farm_eye_osm_map_page.dart';
import 'package:farm_eye_app/pages/farm_eye_osm_map_locations_page.dart';
import 'package:farm_eye_app/pages/farm_eye_osm_map_path_draw_page.dart';
import 'package:flutter/material.dart';

class ScreenRoutes {
  static const String toLogin = "toLogin";
  static const String toHomePage="toHomePage";
  static const String toSplashPage="toSplashPage";
  static const String toFarmEyeMapPage="toFarmEyeMapPage";
  static const String toSampleCollectPage="toSampleCollectPage";
  static const String toFarmEyeMapPathPage="toFarmEyeMapPathPage";
  static const String toFarmEyeOsmMapPage="toFarmEyeOsmMapPage";
  static const String toFarmEyeOsmMapLocationsPage="toFarmEyeOsmMapLocationsPage";
  static const String toFarmEyeOsmMapPathDrawPage="toFarmEyeOsmMapPathDrawPage";
  static const String toFarmEyeOsmLocationTracking="toFarmEyeOsmLocationTracking";
}

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.toSplashPage:
        return MaterialPageRoute(builder: (_) =>  SplashScreen(title: ""));
      case ScreenRoutes.toHomePage:
        return MaterialPageRoute(builder: (_)=>const HomePage());
      case ScreenRoutes.toFarmEyeMapPage:
        return MaterialPageRoute(builder: (_)=>FarmEyeMapPage());
      case ScreenRoutes.toSampleCollectPage:
        return MaterialPageRoute(builder: (_)=>SampleCollectPage());
      case ScreenRoutes.toFarmEyeMapPathPage:
        return MaterialPageRoute(builder: (_)=>FarmEyeMapPathPage());
      case ScreenRoutes.toFarmEyeOsmMapPage:
        return MaterialPageRoute(builder: (_)=>FarmEyeOsmMapPage());
      case ScreenRoutes.toFarmEyeOsmMapLocationsPage:
        return MaterialPageRoute(builder: (_)=>FarmEyeOsmMapLocationsPage());
      case ScreenRoutes.toFarmEyeOsmMapPathDrawPage:
        return MaterialPageRoute(builder: (_)=>FarmEyeOsmMapPathDrawPage());
      case ScreenRoutes.toFarmEyeOsmLocationTracking:
        return MaterialPageRoute(builder: (_)=>FarmEyeOsmLocationTracking());
      default:
        return MaterialPageRoute(builder: (_)=>const HomePage());
    }
  }
}
