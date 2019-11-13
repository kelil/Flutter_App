import 'package:flutter/material.dart';

enum AppTheme {
  GreyLight,
  GreyDark,
  GreenLight,
  GreenDark,
  BlueLight,
  BlueDark,
  BrownLight,
  BrownDark,
  RedLight,
  RedDark,
}

final appThemeData = {
  AppTheme.GreenLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
  ),
  AppTheme.GreenDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
  ),
  AppTheme.BlueLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
  ),
  AppTheme.BlueDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue[700],
  ),
  AppTheme.BrownLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.brown,
  ),
  AppTheme.BrownDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.brown[700],
  ),
  AppTheme.RedLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.redAccent,
  ),
  AppTheme.RedDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red[700],
  ),
  AppTheme.GreyLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey[700],
  ),
  AppTheme.GreyDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
  ),
};
