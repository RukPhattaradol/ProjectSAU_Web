import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class fontstyle {
  static TextStyle dashboardTextStyle(BuildContext context) {
    return GoogleFonts.kanit(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.02,
      color: Colors.white,
    );
  }
}

class fontstylenav {
  static TextStyle dashboardTextStyle(BuildContext context) {
    return GoogleFonts.kanit(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.01,
      color: Colors.white,
    );
  }
}

class fontstylelist {
  static TextStyle dashboardTextStyle(BuildContext context) {
    return GoogleFonts.kanit(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.009,
      color: Colors.white,
    );
  }
}

class fontstylelogin {
  static TextStyle dashboardTextStyle(BuildContext context) {
    return GoogleFonts.kanit(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.02,
      color: Color.fromARGB(255, 0, 0, 0),
    );
  }
}

class fontstyleBGwhite {
  static TextStyle dashboardTextStyle(BuildContext context) {
    return GoogleFonts.kanit(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.02,
      color: Color.fromARGB(255, 7, 15, 43),
    );
  }
}

class fontstylegauge {
  static TextStyle dashboardTextStyle(BuildContext context) {
    return GoogleFonts.kanit(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.007,
      color: Color.fromARGB(255, 255, 255, 255),
    );
  }
}

class fontstylecontact {
  static TextStyle dashboardTextStyle(BuildContext context) {
    return GoogleFonts.kanit(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.010,
      color: Color.fromARGB(255, 255, 255, 255),
    );
  }
}

class fonttablestyle {
  static TextStyle dashboardTextStyle(BuildContext context) {
    return GoogleFonts.kanit(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.007,
      color: Color.fromARGB(255, 255, 255, 255),
    );
  }
}
