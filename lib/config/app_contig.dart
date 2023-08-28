import 'package:flutter/material.dart';
import 'package:flutter_mask/config/environment.dart';

class AppConfig {
  static const MaterialColor defaultAppThemeColor = Colors.blue;
  static const MaterialColor productionAppThemeColor = Colors.red;

  static final AppConfig _instance = AppConfig._internal();

  Environment? _environment;

  // constructors
  AppConfig._internal();

  factory AppConfig.instance({
    String flavor = "dev",
  }) {
    final buildType = BuildType.byFlavor(flavor);
    _instance._environment = Environment.instance(buildType: buildType);

    return _instance;
  }

  MaterialColor get appThemeColor => _environment == null || _environment!.isDev
      ? defaultAppThemeColor
      : productionAppThemeColor;
}
