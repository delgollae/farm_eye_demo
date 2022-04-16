import 'package:flutter/material.dart';

extension AppTextStyles on TextTheme {
  TextStyle get normalTextStyle{
    return const TextStyle(
      fontSize: 15.0,
      // color: AppColors.normalTextColor,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get blackTextStyle14pt {
    return const TextStyle(
        color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);
  }
}