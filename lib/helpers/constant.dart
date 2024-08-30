import 'package:flutter/material.dart';

const kMainColor = Color(0xFFFF8400);
const kGreyTextColor = Color(0xFF959595);
const kBorderColorTextField = Color(0xFFC2C2C2);
const kDarkWhite = Color(0xFFFFFFFF);
const kTitleColor = Color(0xFF040404);
const kAlertColor = Color(0xFFFF8919);
const kBgColor = Color(0xFFF7F7F8);
const kRedColor = Color(0xFFFF3232);
const kRedBlue = Color(0xFF1976D2);
const kRedBlue3 = Color(0xFF1976D2);

const kWhiteColor = Colors.white;
const kBlackColor = Colors.blue;
const appColor = Colors.blueAccent;
const kTransparent = Colors.transparent;

//Paypal Settings
const String paypalClientId =
    'ATKxCBB49G3rPw4DG_0vDmygbZeFKubzub7jGWpeUW5jzfElK9qOzqJOfrBTYvS7RuIhoPdWHB4DIdLJ';
const String paypalClientSecret =
    'EIDqVfraXlxDBMnswmhqP2qYv6rr_KPDgK269T-q1K9tB455OpPL_fc65irFiPBpiVXcoOQwpKqU3PAu';
const bool sandbox = true;
const String currency = 'INR';
const String currencyIcon = '\u{20B9}';

//Onesignal Settings
const String oneSignalAppId = 'c031bb73-7033-4ca9-bf1e-06c56e2e462c';

//Razorpay Settings
const String companyName = 'Zapurse';
const String razorPayApiKey = 'rzp_test_BWqfBmcCYhpsci';
const String companyDescription = 'Atishay Limited';



const kButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(5),
  ),
);

const kInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: kBorderColorTextField),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: const BorderSide(
      color: Color(0xFFE8E7E5),
    ),
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

