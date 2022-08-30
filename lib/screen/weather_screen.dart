import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:weather/model/weather_model.dart';

import '../constanse/constans.dart';
import 'details_screen.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  fetchData(String city) async {
    try {
      var searchResult = await http.get(Uri.parse(searchWeatherAPI + city));
      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No data');
      var locationData = weatherData['location'];
      var currentWeather = weatherData['current'];
      setState(() {
        location = getShortLocationName(locationData['name']);

        var parsedDate =
        DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        currentDate = newDate;

        currentWeatherState = currentWeather['condition']['text'];
        weatherIcon =
            currentWeatherState.replaceAll(' ', '').toLowerCase() + ".png";
        temperature = currentWeather['temp_c'].toInt();
        windSpeed = currentWeather['wind_kph'].toInt();
        humidity = currentWeather['humidity'].toInt();
        cloud = currentWeather['cloud'].toInt();

        dailyWeatherForecast = weatherData['forecast']['forecastday'];
        hourlyWeatherForecast = dailyWeatherForecast[0]['hour'];
        print(dailyWeatherForecast);
      });
    } catch (e) {
      print(e);
    }
  }

  static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + " " + wordList[1];
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }
  @override
  void initState() {
    fetchData(location);
    super.initState();
  }
  final appBar = AppBar();
  TextEditingController _cityController = TextEditingController();
  Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: LayoutBuilder(
        builder: (context, constrains) {
          return Column(
            children: [
              Container(
                  height: constrains.maxHeight * 0.70, child: LayoutBuilder(
                builder: (context, constrains)
                {
                  return GlowContainer(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.only(
                        top: constrains.maxHeight > 896.0
                            ? constrains.maxHeight * 0.12
                            : constrains.maxHeight > 800
                            ? constrains.maxHeight * 0.19
                            : constrains.maxHeight > 600
                            ? constrains.maxHeight * 0.12
                            : constrains.maxHeight > 400
                            ? constrains.maxHeight * 0.10
                            : constrains.maxHeight * 0.15,
                        // constrains.maxHeight > 700
                        //   ? 40
                        //   : constrains.maxHeight > 600 ? 20 : 10,
                        // top: heightScreen < 900
                        // ? 40
                        // : heightScreen > 700 ? 30 : 10,
                        left: 30,
                        right: 30),
                    glowColor: Color(0xff00A1FF).withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60)),
                    color: Color(0xff00A1FF),
                    spreadRadius: 5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                CupertinoIcons.square_grid_2x2,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10,),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.map_fill,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " " + location,
                                    style: TextStyle(
                                        fontSize: 27, fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _cityController.clear();
                                      showBottomSheet(
                                          context: context,
                                          builder: (context) => SingleChildScrollView(
                                            controller:
                                            ModalScrollController.of(context),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: heightScreen * .2,
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 70,
                                                        child: Divider(
                                                          thickness: 3.5,
                                                          color:
                                                          _constants.primaryColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(color: Colors.black),
                                                        onChanged: (searchText) {
                                                          fetchData(searchText);
                                                        },
                                                        controller: _cityController,
                                                        autofocus: true,
                                                        decoration: InputDecoration(
                                                            prefixIcon: Icon(
                                                              Icons.search,
                                                              color: _constants
                                                                  .primaryColor,
                                                            ),
                                                            suffixIcon: GestureDetector(
                                                              onTap: () =>
                                                                  _cityController
                                                                      .clear(),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: _constants
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                            hintText:
                                                            'Search city e.g. Jerusalem',
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: _constants
                                                                    .primaryColor,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Container(
                            // height: constrains.maxHeight * 0.11,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 0.2, color: Colors.white),
                            ),
                            child: Text(
                              "Updating",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            // color: Colors.redAccent,
                            padding: EdgeInsets.zero,
                            height: constrains.maxHeight > 896.0
                                ? constrains.maxHeight * 0.80
                                : constrains.maxHeight > 600
                                ? constrains.maxHeight * 0.73
                                : constrains.maxHeight * 0.74,
                            // width: widthScreen ,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -25,
                                  right: 0,
                                  left: 0,
                                  // top: -30,
                                  child: Container(
                                    // height: constrains.minHeight * 0.80,
                                    // height: constrains.minHeight * 0.50,
                                    // height: constrains.maxHeight > 1024
                                    //     ? constrains.maxHeight * 0.49
                                    //     : constrains.maxHeight > 600
                                    //         ? constrains.maxHeight * 0.48
                                    //         : constrains.maxHeight > 4006
                                    //             ? constrains.maxHeight * 0.50
                                    //             : 0.50,
                                    child: Image(
                                      image: AssetImage('assets/' + weatherIcon),
                                      fit: BoxFit.fill,
                                      height: constrains.minHeight * 0.55,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Column(
                                    children: [
                                      FittedBox(
                                        child: GlowText(
                                          temperature.toString(),
                                          style: TextStyle(
                                              height: 0.1,
                                              fontSize: 93,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        currentWeatherState,
                                        style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        currentDate,
                                        style:
                                        TextStyle(fontSize: 16, color: Colors.white70),
                                      ),
                                      SizedBox(
                                        height: constrains.maxHeight > 600
                                            ? 40
                                            : constrains.maxHeight > 400
                                            ? 5
                                            : 0,
                                      ),
                                      Divider(
                                        color: Colors.white,
                                      ),
                                      Container(
                                          height: constrains.maxHeight > 1024
                                              ? constrains.maxHeight * 0.19
                                              : constrains.maxHeight > 600
                                              ? constrains.maxHeight * 0.14
                                              : constrains.maxHeight > 400
                                              ? constrains.maxHeight * 0.17
                                              : 0.19,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    windSpeed.toString() + " Km/h",
                                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Image.asset(
                                                    "assets/windspeed.png", height: 40, width: 40,
                                                    // style: TextStyle(color: Colors.black54, fontSize: 16),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    humidity.toString() + " %",
                                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Image.asset(
                                                    "assets/humidity.png", height: 40, width: 40,
                                                    // style: TextStyle(color: Colors.black54, fontSize: 16),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    cloud.toString() + " %",
                                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Image.asset(
                                                    "assets/cloud.png", height: 40, width: 40,
                                                    // style: TextStyle(color: Colors.black54, fontSize: 16),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },

                  ),),
              Expanded(
                  child: Container(
                      height: constrains.maxHeight * 0.3,
                      child: LayoutBuilder(
                        builder: (context, constrains)
                        {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: constrains.maxHeight * 0.10,
                                left: constrains.maxHeight * 0.11,
                                right: constrains.maxHeight * 0.11),
                            child: SingleChildScrollView(
                              child: Container(
                                // color: Colors.redAccent,
                                child: Column(
                                  children: [
                                    Container(
                                      height: constrains.maxHeight * 0.15,
                                      // color: Colors.green,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Today",
                                            style: TextStyle(
                                                fontSize: 25, fontWeight: FontWeight.bold),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => DetailsScreen(dailyForecastWeather: dailyWeatherForecast,)));
                                            },
                                            child: Row(
                                              children: const [
                                                FittedBox(
                                                  child: Text(
                                                    "Forecast ",
                                                    style: TextStyle(
                                                        fontSize: 18, color: Color(0xff6b9dfc)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: constrains.maxHeight * 0.10,
                                    ),
                                    Container(
                                      // color: Colors.blue,
                                      // margin: const EdgeInsets.only(bottom: 30),
                                      height: constrains.maxWidth * 0.31,
                                      width: constrains.maxWidth ,
                                      child: ListView.builder(
                                        itemCount: hourlyWeatherForecast.length,
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          String currentTime =
                                          DateFormat('HH:mm:ss').format(DateTime.now());
                                          String currentHour = currentTime.substring(0, 2);

                                          String forecastTime = hourlyWeatherForecast[index]
                                          ["time"]
                                              .substring(11, 16);
                                          String forecastHour = hourlyWeatherForecast[index]
                                          ["time"]
                                              .substring(11, 13);

                                          String forecastWeatherName =
                                          hourlyWeatherForecast[index]["condition"]["text"];
                                          String forecastWeatherIcon = forecastWeatherName
                                              .replaceAll('', '')
                                              .toLowerCase() +
                                              ".png";

                                          String forecastTemperature =
                                          hourlyWeatherForecast[index]["temp_c"]
                                              .round()
                                              .toString();
                                          return Container(
                                            padding: const EdgeInsets.symmetric(vertical: 15),
                                            margin: const EdgeInsets.only(right: 20),
                                            width: 65,
                                            decoration: BoxDecoration(
                                                color: currentHour == forecastHour
                                                    ? Colors.white
                                                    : _constants.primaryColor,
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(50)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: const Offset(0, 1),
                                                    blurRadius: 5,
                                                    color:
                                                    _constants.primaryColor.withOpacity(.2),
                                                  ),
                                                ]),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  forecastTime,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: _constants.greyColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Image.asset(
                                                  'assets/' + forecastWeatherIcon,
                                                  height: 39,
                                                  width: 39,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      forecastTemperature,
                                                      style: TextStyle(
                                                        color: _constants.greyColor,
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      'o',
                                                      style: TextStyle(
                                                        color: _constants.greyColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 17,
                                                        fontFeatures: const [
                                                          FontFeature.enable('sups'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                      )))
            ],
          );
        },
      ),
    );
  }
}
//
// class TodayWeather extends StatefulWidget {
//   @override
//   State<TodayWeather> createState() => _TodayWeatherState();
// }
//
// class _TodayWeatherState extends State<TodayWeather> {
//   final appBar = AppBar();
//
//   Constants _constants = Constants();
//
//   @override
//   Widget build(BuildContext context) {
//     final heightScreen = MediaQuery.of(context).size.height -
//         appBar.preferredSize.height -
//         MediaQuery.of(context).padding.top;
//     final widthScreen = MediaQuery.of(context).size.width;
//     return LayoutBuilder(
//       builder: (context, constrains) {
//         return Padding(
//           padding: EdgeInsets.only(
//               top: constrains.maxHeight * 0.10,
//               left: constrains.maxHeight * 0.11,
//               right: constrains.maxHeight * 0.11),
//           child: SingleChildScrollView(
//             child: Container(
//               // color: Colors.redAccent,
//               child: Column(
//                 children: [
//                   Container(
//                     height: constrains.maxHeight * 0.10,
//                     // color: Colors.green,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Today",
//                           style: TextStyle(
//                               fontSize: 25, fontWeight: FontWeight.bold),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => DetailsScreen(dailyForecastWeather: dailyWeatherForecast,)));
//                           },
//                           child: Row(
//                             children: const [
//                               FittedBox(
//                                 child: Text(
//                                   "Forecast ",
//                                   style: TextStyle(
//                                       fontSize: 18, color: Color(0xff6b9dfc)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: constrains.maxHeight * 0.10,
//                   ),
//                   Container(
//                     // color: Colors.blue,
//                     // margin: const EdgeInsets.only(bottom: 30),
//                     height: constrains.minHeight * 0.45,
//                     child: ListView.builder(
//                       itemCount: hourlyWeatherForecast.length,
//                       scrollDirection: Axis.horizontal,
//                       physics: const BouncingScrollPhysics(),
//                       itemBuilder: (BuildContext context, int index) {
//                         String currentTime =
//                             DateFormat('HH:mm:ss').format(DateTime.now());
//                         String currentHour = currentTime.substring(0, 2);
//
//                         String forecastTime = hourlyWeatherForecast[index]
//                                 ["time"]
//                             .substring(11, 16);
//                         String forecastHour = hourlyWeatherForecast[index]
//                                 ["time"]
//                             .substring(11, 13);
//
//                         String forecastWeatherName =
//                             hourlyWeatherForecast[index]["condition"]["text"];
//                         String forecastWeatherIcon = forecastWeatherName
//                                 .replaceAll('', '')
//                                 .toLowerCase() +
//                             ".png";
//
//                         String forecastTemperature =
//                             hourlyWeatherForecast[index]["temp_c"]
//                                 .round()
//                                 .toString();
//                         return Container(
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           margin: const EdgeInsets.only(right: 20),
//                           width: 65,
//                           decoration: BoxDecoration(
//                               color: currentHour == forecastHour
//                                   ? Colors.white
//                                   : _constants.primaryColor,
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(50)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   offset: const Offset(0, 1),
//                                   blurRadius: 5,
//                                   color:
//                                       _constants.primaryColor.withOpacity(.2),
//                                 ),
//                               ]),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   forecastTime,
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     color: _constants.greyColor,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Image.asset(
//                                   'assets/' + forecastWeatherIcon,
//                                   height: 39,
//                                   width: 39,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       forecastTemperature,
//                                       style: TextStyle(
//                                         color: _constants.greyColor,
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     Text(
//                                       'o',
//                                       style: TextStyle(
//                                         color: _constants.greyColor,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 17,
//                                         fontFeatures: const [
//                                           FontFeature.enable('sups'),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class CurrentWeather extends StatefulWidget {
//   @override
//   State<CurrentWeather> createState() => _CurrentWeatherState();
// }
//
// class _CurrentWeatherState extends State<CurrentWeather> {
//   fetchData(String city) async {
//     try {
//       var searchResult = await http.get(Uri.parse(searchWeatherAPI + city));
//       final weatherData = Map<String, dynamic>.from(
//           json.decode(searchResult.body) ?? 'No data');
//       var locationData = weatherData['location'];
//       var currentWeather = weatherData['current'];
//       setState(() {
//         location = getShortLocationName(locationData['name']);
//
//         var parsedDate =
//             DateTime.parse(locationData["localtime"].substring(0, 10));
//         var newDate = DateFormat('MMMMEEEED').format(parsedDate);
//         currentDate = newDate;
//
//         currentWeatherState = currentWeather['condition']['text'];
//         weatherIcon =
//             currentWeatherState.replaceAll(' ', '').toLowerCase() + ".png";
//         temperature = currentWeather['temp_c'].toInt();
//         windSpeed = currentWeather['wind_kph'].toInt();
//         humidity = currentWeather['humidity'].toInt();
//         cloud = currentWeather['cloud'].toInt();
//
//         dailyWeatherForecast = weatherData['forecast']['forecastday'];
//         hourlyWeatherForecast = dailyWeatherForecast[0]['hour'];
//         print(dailyWeatherForecast);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   static String getShortLocationName(String s) {
//     List<String> wordList = s.split(" ");
//
//     if (wordList.isNotEmpty) {
//       if (wordList.length > 1) {
//         return wordList[0] + " " + wordList[1];
//       } else {
//         return wordList[0];
//       }
//     } else {
//       return " ";
//     }
//   }
//
//   @override
//   void initState() {
//     fetchData(location);
//     super.initState();
//   }
//
//   TextEditingController _cityController = TextEditingController();
//
//   Constants _constants = Constants();
//
//   @override
//   Widget build(BuildContext context) {
//     final heightScreen = MediaQuery.of(context).size.height;
//     final widthScreen = MediaQuery.of(context).size.width;
//     print(heightScreen);
//     print(widthScreen);
//     return LayoutBuilder(
//       builder: (context, constrains) {
//         return GlowContainer(
//           margin: EdgeInsets.only(left: 10, right: 10),
//           padding: EdgeInsets.only(
//               top: constrains.maxHeight > 896.0
//                   ? constrains.maxHeight * 0.12
//                   : constrains.maxHeight > 800
//                       ? constrains.maxHeight * 0.19
//                       : constrains.maxHeight > 600
//                           ? constrains.maxHeight * 0.12
//                           : constrains.maxHeight > 400
//                               ? constrains.maxHeight * 0.10
//                               : constrains.maxHeight * 0.15,
//               // constrains.maxHeight > 700
//               //   ? 40
//               //   : constrains.maxHeight > 600 ? 20 : 10,
//               // top: heightScreen < 900
//               // ? 40
//               // : heightScreen > 700 ? 30 : 10,
//               left: 30,
//               right: 30),
//           glowColor: Color(0xff00A1FF).withOpacity(0.5),
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(60),
//               bottomRight: Radius.circular(60)),
//           color: Color(0xff00A1FF),
//           spreadRadius: 5,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Icon(
//                       CupertinoIcons.square_grid_2x2,
//                       color: Colors.white,
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           CupertinoIcons.map_fill,
//                           color: Colors.white,
//                         ),
//                         Text(
//                           " " + location,
//                           style: TextStyle(
//                               fontSize: 27, fontWeight: FontWeight.bold),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             _cityController.clear();
//                             showBottomSheet(
//                                 context: context,
//                                 builder: (context) => SingleChildScrollView(
//                                       controller:
//                                           ModalScrollController.of(context),
//                                       child: Stack(
//                                         children: [
//                                           Container(
//                                             height: heightScreen * .2,
//                                             padding: const EdgeInsets.symmetric(
//                                               horizontal: 20,
//                                               vertical: 10,
//                                             ),
//                                             child: Column(
//                                               children: [
//                                                 SizedBox(
//                                                   width: 70,
//                                                   child: Divider(
//                                                     thickness: 3.5,
//                                                     color:
//                                                         _constants.primaryColor,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 TextFormField(
//                                                   onChanged: (searchText) {
//                                                     fetchData(searchText);
//                                                   },
//                                                   controller: _cityController,
//                                                   autofocus: true,
//                                                   decoration: InputDecoration(
//                                                       prefixIcon: Icon(
//                                                         Icons.search,
//                                                         color: _constants
//                                                             .primaryColor,
//                                                       ),
//                                                       suffixIcon: GestureDetector(
//                                                         onTap: () =>
//                                                             _cityController
//                                                                 .clear(),
//                                                         child: Icon(
//                                                           Icons.close,
//                                                           color: _constants
//                                                               .primaryColor,
//                                                         ),
//                                                       ),
//                                                       hintText:
//                                                           'Search city e.g. London',
//                                                       focusedBorder:
//                                                           OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                           color: _constants
//                                                               .primaryColor,
//                                                         ),
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                                 10),
//                                                       )),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ));
//                           },
//                           icon: const Icon(
//                             Icons.keyboard_arrow_down,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Icon(
//                       Icons.more_vert,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//                 Container(
//                   // height: constrains.maxHeight * 0.11,
//                   margin: EdgeInsets.only(top: 10),
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     border: Border.all(width: 0.2, color: Colors.white),
//                   ),
//                   child: Text(
//                     "Updating",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Container(
//                   // color: Colors.redAccent,
//                   padding: EdgeInsets.zero,
//                   height: constrains.maxHeight > 896.0
//                       ? constrains.maxHeight * 0.80
//                       : constrains.maxHeight > 600
//                           ? constrains.maxHeight * 0.73
//                           : constrains.maxHeight * 0.74,
//                   // width: widthScreen ,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         top: -30,
//                         right: 0,
//                         left: 0,
//                         // top: -30,
//                         child: Container(
//                           height: constrains.minHeight * 0.50,
//                           // height: constrains.maxHeight > 1024
//                           //     ? constrains.maxHeight * 0.49
//                           //     : constrains.maxHeight > 600
//                           //         ? constrains.maxHeight * 0.48
//                           //         : constrains.maxHeight > 4006
//                           //             ? constrains.maxHeight * 0.50
//                           //             : 0.50,
//                           child: ClipRRect(
//                             child: Image(
//                               image: AssetImage('assets/' + weatherIcon),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         left: 0,
//                         child: Column(
//                           children: [
//                             FittedBox(
//                               child: GlowText(
//                                 temperature.toString(),
//                                 style: TextStyle(
//                                     height: 0.1,
//                                     fontSize: 93,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               currentWeatherState,
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(
//                               height: 3,
//                             ),
//                             Text(
//                               currentDate,
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.white70),
//                             ),
//                             SizedBox(
//                               height: constrains.maxHeight > 600
//                                   ? 40
//                                   : constrains.maxHeight > 400
//                                       ? 5
//                                       : 0,
//                             ),
//                             Divider(
//                               color: Colors.white,
//                             ),
//                             Container(
//                                 height: constrains.maxHeight > 1024
//                                     ? constrains.maxHeight * 0.19
//                                     : constrains.maxHeight > 600
//                                         ? constrains.maxHeight * 0.14
//                                         : constrains.maxHeight > 400
//                                             ? constrains.maxHeight * 0.17
//                                             : 0.19,
//                                 child: ExtraWeather(currentTemp)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class ExtraWeather extends StatelessWidget {
//   final WeatherModel temp;
//
//   ExtraWeather(this.temp);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           children: [
//             SizedBox(
//               height: 8,
//             ),
//             Text(
//               windSpeed.toString() + " Km/h",
//               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Image.asset(
//               "assets/windspeed.png", height: 40, width: 40,
//               // style: TextStyle(color: Colors.black54, fontSize: 16),
//             )
//           ],
//         ),
//         Column(
//           children: [
//             SizedBox(
//               height: 8,
//             ),
//             Text(
//               humidity.toString() + " %",
//               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Image.asset(
//               "assets/humidity.png", height: 40, width: 40,
//               // style: TextStyle(color: Colors.black54, fontSize: 16),
//             )
//           ],
//         ),
//         Column(
//           children: [
//             SizedBox(
//               height: 8,
//             ),
//             Text(
//               cloud.toString() + " %",
//               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Image.asset(
//               "assets/cloud.png", height: 40, width: 40,
//               // style: TextStyle(color: Colors.black54, fontSize: 16),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }


