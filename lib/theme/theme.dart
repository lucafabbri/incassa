import 'package:flutter/material.dart';

class IncassaTheme {
  static Color primary = Colors.deepOrange.shade900;
  static Color primaryAccent = Colors.deepOrange.shade400;

  static ButtonStyle darkTextButtonStyle = TextButton.styleFrom(
      primary: Colors.black,
      backgroundColor: Colors.yellow.shade600,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: Colors.white, width: 1)));
  static ButtonStyle lightTextButtonStyle = TextButton.styleFrom(
      primary: Colors.black,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: Colors.white, width: 1)));
  static ButtonStyle primaryTextButtonStyle = TextButton.styleFrom(
      primary: Colors.black,
      backgroundColor: IncassaTheme.primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: Colors.white, width: 1)));
  static ButtonStyle holdindTextButtonStyle = TextButton.styleFrom(
      primary: Colors.black,
      backgroundColor: IncassaTheme.primaryAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: IncassaTheme.primaryAccent, width: 5)));
  static ButtonStyle inactiveTextButtonStyle = TextButton.styleFrom(
      primary: Colors.black45,
      backgroundColor: Colors.white70,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: Colors.white, width: 1)));
}
