import 'dart:io';
import 'package:farm_eye_app/parameters.dart';

const int IMAGE_UP_QUALITY = 40;
const seylanBankCode="7287";
class LoginMethods {
//  static const int PASSWORD = 1;
  static const int NO_LOGIN_METHOD = -1;
  static const int PIN = 0;
  static const int BIOMETRIC = 1;
}

class Keys {
  static const String LOGIN_FLAG = "param2";
  static const String USERNAME = "param3";
  static const String TOKEN = "param4";
  static const String SPLASH_URL = "splash_url";
  static const String AUTHSCREEN_URL = "auth_screen_url";
}

class TransactionTypes {
  static const String MERCHANT_PAY = 'MERCHANT_PAY';
  static const String BILL_PAY = "BILL_PAY";
  static const String FUND_TRANSFER = "FUND_TRANSFER";
  static const String CREDIT_CARD_PAYMENT = "CREDIT_CARD_PAYMENT";
}

class Settings {
  static const int MAX_IDLE_TIME_IN_SECONDS = isDev ? 600 : 180;
}

class PaymentMethodTab {
  static const int ACCOUNT = 0;
  static const int CARD = 1;
}

class ErrorCodes {
  static const String DEVICE_NOT_REGISTERED = "DeviceNotRegistered";
  static const String ACCOUNT_CONSENT_REQUIRED = "AccountConsentRequired";
  static const String NIC_IMG_REQUIRED="NicImgRequired";
}

class ErrorMessages {
  static const String UNEXPECTED_ERROR =
      "Please try again. If the problem persists please contact customer support";
}


class Region {
  static const String MTF = "test-";
  static const String ASIA_PACIFIC = "ap-";
  static const String EUROPE = "eu-";
  static const String NORTH_AMERICA = "na-";
}

class GatewayResponse {
  static const String AUTHENTICATION_SUCCESSFUL = "AUTHENTICATION_SUCCESSFUL";
  static const String AUTHENTICATION_ATTEMPTED = "AUTHENTICATION_ATTEMPTED";
  static const String REDIRECT_SCHEMA = "https";
  static const String ACS_RESULT = "acsResult";
}

class UI {
  static const double PADDING = 8.0;
  static const double PADDING_2X = PADDING * 2;
  static const double PADDING_3X = PADDING * 3;
  static const double PADDING_4X = PADDING * 4;
  static const double PADDING_5X = PADDING * 5;
  static const double PADDING_8X = PADDING * 8;
  static const double PADDING_12X = PADDING * 12;
  static const double PADDING_16X = PADDING * 16;
  static const double PADDING_32X = PADDING * 32;
  static const double BORDER_RADIUS = 5.0;
  static const int ANIM_DURATION = 300;
}
class ScheduleTypes{
  static  String oneTime="One Time";
  static String monthly="Monthly";
}

class Status {
  static const String ACTIVE = "Active";
  static const String DEACTIVE = "Deactivated";
}

String getPlatform() {
  if (Platform.isIOS) {
    return "IOS";
  } else if (Platform.isAndroid) {
    return "Android";
  } else {
    return "NA";
  }
}
