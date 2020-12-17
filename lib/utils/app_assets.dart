import 'dart:ui';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppImages {
  static const icUserName = 'assets/drawables/icons/ic_username.png';
}

class AppFonts{
  static const String Montserrat = 'Montserrat';
  static const String PTSans = 'PTSans';
  static const String OpenSans = 'OpenSans';
}

class AppTextStyle {
  static const TextStyle textWhiteRegular13 = TextStyle(fontFamily: AppFonts.Montserrat, fontSize: 13, color: AppColors.white, fontWeight: FontWeight.w400);
  static const TextStyle textRegular13 = TextStyle(fontFamily: AppFonts.Montserrat, fontSize: 13, color: AppColors.nightRider, fontWeight: FontWeight.w400);
  static const TextStyle textWhiteBold = TextStyle(fontFamily: AppFonts.Montserrat, fontSize: 13, color: AppColors.white, fontWeight: FontWeight.w700);
  static const TextStyle textWarning = TextStyle(fontFamily: AppFonts.Montserrat, fontSize: 13, color: Colors.red, fontWeight: FontWeight.w400);
}