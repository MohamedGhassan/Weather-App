// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:weather/model/weather_model.dart';
//
// class WebServices {
//   static String API_KEY = '0b094f5d615549f9873114436222808';
//   String appId = '59f9d6fd3d9fc3e419656a54f7ccf3db';
//   String location = 'Jerusalem';
//   String WeatherIcon = 'assets/heavycloudy.png';
//   int temperature = 0;
//   int windSpeed = 0;
//   int humidity = 0;
//   int cloud = 0;
//   int currentDate = 0;
//
//   List hourlyWeatherForcast= [];
//   List dailyWeatherForcast= [];
//
//   String currentWeatherState = '';
//
//   String searchWeatherAPI = "https://api.weatherapi.com/v1/forecast.json?key=" +
//       API_KEY +
//       "&days=7&q=";
//   Future<List> fetchData(String city) async
//   {
//     // var url = 'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
//     // var response = await http.get(Uri.parse(url));
//     // DateTime time = DateTime.now();
//     // if (response.statusCode == 200) {
//     //   var res = json.decode(response.body);
//     //   var main = res['main'];
//     //   var weather = res['weather'];
//     //   WeatherModel currentTemp = WeatherModel(
//     //       current: main['temp']?.round() ?? 0,
//     //       name: weather['main']
//     //   )
//     // }
//     var searchResult = await http.get(Uri.parse(searchWeatherAPI + city));
//     final weatherData = Map<String, dynamic>.from(json.decode(searchResult.body) ?? 'No data');
//     var locationData = weatherData['location'];
//     var currentWeather = weatherData['current'];
//
//     setState(()
//     {
//       location = locationData['name'];
//       print(location);
//     });
//   }
// }