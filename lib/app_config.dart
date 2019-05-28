import 'package:flutter/material.dart';

enum AppEnvironment {DEV, STAGE, PROD}

class AppConfig {
  // Singleton object
  static final AppConfig _singleton =
      new AppConfig._internal();

  factory AppConfig() {
    return _singleton;
  }

  AppConfig._internal();

  AppEnvironment appEnvironment;
  String apiUrl;
  String loginUrl;
  ThemeData themeData;

  // Set app configuration with single function
  void setAppConfig({AppEnvironment appEnvironment, String apiUrl, String loginUrl, ThemeData themeData}) {
    this.appEnvironment   = appEnvironment;
    this.apiUrl           = apiUrl;
    this.loginUrl         = loginUrl;
    this.themeData        = themeData;
  }
}