import 'package:flutter/material.dart';

const SM_SCREEN_HEIGHT = 560.0;
const SM_SCREEN_WIDTH = 320.0;

const MD_SCREEN_HEIGHT = 820.0;
const MD_SCREEN_WIDTH = 420.0;

const LG_SCREEN_HEIGHT = 900.0;
const LG_SCREEN_WIDTH = 420.0;

class ScreenUtils {
  static Size? screenSize;
  static MediaQueryData? mqData;
  static double containerBoxHeight = 410.0;

  static double topBarHeight = 152;
  static double bottomBarHeight = 95;

  static double get safeArea => mqData != null ? mqData!.padding.top : 0;
  static Size? get size => screenSize;
  static double get height => size!.height;
  static double get width => size!.width;
}

double getCalaculatedHeight(BuildContext context, double height) {
  double designScreenHeight = 812;
  final screenHeight = ScreenUtils.screenSize!.height;// MediaQuery.of(context).size.height;
  // printLogs("height: $screenHeight");

  if (screenHeight <= 480) {
    double calculatedHeight = (height / designScreenHeight) * screenHeight;
    return calculatedHeight;
  } else if (screenHeight <= 667.0) {
    return height * 0.9;
  } else {
    return height;
  }
}

double getCalculatedWidth(BuildContext context, double width) {
  final screenWidth = ScreenUtils.screenSize!.width;//MediaQuery.of(context).size.width;

  if (screenWidth <= 320) {
    return width * 0.76;
  } else if (screenWidth <= 375) {
    return width * 0.76;
  } else {
    return width;
  }
}

double setSizeFromScreenType(BuildContext context, double originalSize,
    {double? sm, double? md, double? lg}) {
  onScreenSize(context, onSmallScreen: (h, w) {
    if (sm != null) {
      originalSize = sm;
    }
  }, onMediumScreen: (h, w) {
    if (md != null) {
      originalSize = md;
    }
  }, onLargeScreen: (h, w) {
    if (lg != null) {
      originalSize = lg;
    }
  });
  return originalSize;
}

onScreenSize(BuildContext? context,
    {Size? size,
    Function(double, double)? onSmallScreen,
    Function(double, double)? onMediumScreen,
    Function(double, double)? onLargeScreen}) {
  if (context == null && size == null) {
    throw Exception("Context required if size not available!");
  } else if (context != null) {
    size = MediaQuery.of(context).size;
  }

  final width = size!.width;
  final height = size.height;

  if (width <= SM_SCREEN_WIDTH &&
      height <= SM_SCREEN_HEIGHT &&
      onSmallScreen != null) {
    onSmallScreen(height, width);
  } else if (width <= MD_SCREEN_WIDTH &&
      height <= MD_SCREEN_HEIGHT &&
      onMediumScreen != null) {
    onMediumScreen(height, width);
  } else if (onLargeScreen != null) {
    onLargeScreen(height, width);
  }
}
