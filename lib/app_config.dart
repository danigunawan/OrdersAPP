import 'package:flutter/material.dart';

enum AppEnvironment { DEV, STAGE, PROD }

class AppConfig {
  // Singleton object
  static final AppConfig _singleton = new AppConfig._internal();

  factory AppConfig() {
    return _singleton;
  }

  AppConfig._internal();

  AppEnvironment appEnvironment;
  String apiUrl;
  String loginUrl;
  String themeName;
  ThemeData themeData;

  var appThemes = {
    'dark': ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColor: Colors.green,
        brightness: Brightness.dark),
    'light': ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: Colors.blue,
        brightness: Brightness.light),
    'default': ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.blue,
        brightness: Brightness.light),
  };

  var appLogos = {
    'dark': Image.asset('assets/logo_dark.png'),
    'light': Image.asset('assets/logo.png'),
    'default': Image.asset('assets/logo.png'),
  };

  // Set app configuration with single function
  void setAppConfig(
      {AppEnvironment appEnvironment,
      String apiUrl,
      String loginUrl,
      String themeName,
      ThemeData themeData}) {
    this.appEnvironment = appEnvironment;
    this.apiUrl = apiUrl;
    this.loginUrl = loginUrl;
    this.themeName = themeName;
    this.themeData = themeData;
  }

  Image getLogo() {
    if (this.themeName == null) {
      this.themeName = 'default';
    }
    return appLogos[this.themeName];
  }

  void setThemeConfig(String themeName) {
    print('AppConfig - 51');
    print(themeName);
    if (themeName == null) {
      this.themeName = 'default';
    } else {
        this.themeName = themeName;
    }
    this.themeData = appThemes[this.themeName];
  }
}
