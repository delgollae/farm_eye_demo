
import 'package:farm_eye_app/pages/farm_eye_map_page.dart';
import 'package:farm_eye_app/pages/home/home_page.dart';
import 'package:farm_eye_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class ScreenRoutes {
  static const String toLogin = "toLogin";
  static const String toHomePage="toHomePage";
  static const String toSplashPage="toSplashPage";
  static const String toFarmEyeMapPage="toFarmEyeMapPage";
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
      default:
        return MaterialPageRoute(builder: (_)=>const HomePage());
    }
  }
}
