
import 'dart:ui';

import 'package:flutter/cupertino.dart';

String API_KEY = '0b094f5d615549f9873114436222808';
String appId = '59f9d6fd3d9fc3e419656a54f7ccf3db';
String location = 'Jerusalem';
String weatherIcon = 'assets/heavycloudy.png';
int temperature = 0;
int windSpeed = 0;
int humidity = 0;
int cloud = 0;
String currentDate = '';

List hourlyWeatherForecast = [];
List dailyWeatherForecast = [];

String currentWeatherState = '';

String searchWeatherAPI = "https://api.weatherapi.com/v1/forecast.json?key=" +
    API_KEY +
    "&days=7&q=";


class Constants {
  final primaryColor = const Color(0xff6b9dfc);
  final secondaryColor = const Color(0xffa1c6fd);
  final tertiaryColor = const Color(0xff205cf1);
  final blackColor = const Color(0xff1a1d26);

  final greyColor = const Color(0xffd9dadb);

  final Shader shader = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final linearGradientBlue =  const LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff6b9dfc), Color(0xff205cf1)],
      stops: [0.0,1.0]
  );
  final linearGradientPurple =  const LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff51087E), Color(0xff6C0BA9)],
      stops: [0.0,1.0]
  );
}

