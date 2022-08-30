import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/screen/weather_screen.dart';

class DetailsScreen extends StatefulWidget {
  final dailyForecastWeather;
  DetailsScreen({Key? key, this.dailyForecastWeather}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  WeatherModel? tomorrowTemp;

  @override
  Widget build(BuildContext context) {
    var weatherData = widget.dailyForecastWeather;
    Map getForecastWeather(int index)
    {
      int maxWindSpeed = weatherData[index]['day']['maxwind_kph'].toInt();
      int avgHumidity = weatherData[index]['day']['avghumidity'].toInt();
      int chanceOfRain = weatherData[index]['day']['daily_chance_of_rain'].toInt();

      var parsedDate = DateTime.parse(weatherData[index]['date']);
      var forecastDate = DateFormat('EEEE').format(parsedDate);

      String weatherName = weatherData[index]['day']['condition']['text'];
      String weatherIcon = weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int maxTemperature = weatherData[index]['day']['maxtemp_c'].toInt();
      int minTemperature = weatherData[index]['day']['mintemp_c'].toInt();

      var forecastData =
      {
        'maxWindSpeed' : maxWindSpeed,
        'avgHumidity' : avgHumidity,
        'chanceOfRain' : chanceOfRain,
        'forecastDate' : forecastDate,
        'weatherName' : weatherName,
        'weatherIcon' : weatherIcon,
        'maxTemperature' : maxTemperature,
        'minTemperature' : minTemperature,
      };
      return forecastData;

    }
    return Scaffold(
      backgroundColor: Color(0xFF030317),
      body: Column(
        children: [
          LayoutBuilder(
            builder: (context, constrains)
            {
              return GlowContainer(
                color: Color(0xff00A1FF),
                glowColor: Color(0xff00A1FF),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 50, right: 30, left: 30, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () 
                              {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Platform.isIOS
                                    ? Icons.arrow_back_ios
                                    : Icons.arrow_back_ios_new,
                                color: Colors.white,
                              )),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "7 days",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.29,
                            height: MediaQuery.of(context).size.width / 2.29,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/" + getForecastWeather(0)['weatherIcon']))),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Tomorrow",
                                style: TextStyle(
                                  fontSize: 30,
                                  height: 0.1,
                                ),
                              ),
                              FittedBox(
                                child: Container(
                                  // height: constrains.maxHeight * 0.15,
                                  height: constrains.maxWidth * 0.25,
                                  // height: 105,
                                  // color: Colors.redAccent,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      FittedBox(
                                        child: GlowText(
                                          getForecastWeather(0)['maxTemperature'].toString(),
                                          style: TextStyle(
                                              fontSize: 100,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),


                                      AutoSizeText(
                                        '/' + getForecastWeather(0)['minTemperature'].toString() + '\u00B0',
                                        style: TextStyle(
                                            color: Colors.black54.withOpacity(0.3),
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              FittedBox(
                                child: Text(
                                  getForecastWeather(0)['weatherName'].toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70
                                    // color: Colors.black54.withOpacity(0.3)
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white70,
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/windspeed.png", height: 40, width: 40,
                                // style: TextStyle(color: Colors.black54, fontSize: 16),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                getForecastWeather(0)['maxWindSpeed'].toString() + " Km/h",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Wind",
                                style: TextStyle(color: Colors.black54, fontSize: 16),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/humidity.png", height: 40, width: 40,
                                // style: TextStyle(color: Colors.black54, fontSize: 16),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                getForecastWeather(0)['avgHumidity'].toString() + " %",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Humidity",
                                style: TextStyle(color: Colors.black54, fontSize: 16),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/lightrain.png", height: 40, width: 40,
                                // style: TextStyle(color: Colors.black54, fontSize: 16),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                getForecastWeather(0)['chanceOfRain'].toString() + " %",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Rain",
                                style: TextStyle(color: Colors.black54, fontSize: 16),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    Text(getForecastWeather(0)['forecastDate'], style: TextStyle(fontSize: 20),),
                    Container(
                      // color: Colors.blue,
                      width: 135,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                        [
                          Image(image: AssetImage("assets/" + getForecastWeather(0)['weatherIcon'].toString()),width: 40,fit: BoxFit.cover,),
                          SizedBox(
                            width: 15,
                          ),
                          Text(getForecastWeather(0)['weatherName'],
                            style: TextStyle(fontSize: 20,color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children:
                      [
                        Text("+" + getForecastWeather(0)['maxTemperature'].toString() + "\u00B0", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(width: 5.0,),
                        Text("+" + getForecastWeather(0)['minTemperature'].toString() + "\u00B0",style: TextStyle(fontSize: 20,color: Colors.grey))
                      ],
                    )
                  ],
                ),
              );
            },
              itemCount: sevenDays.length,),
          ),
        ],
      ),
    );
  }
}

// class TomorrowWeather extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constrains) {
//         return GlowContainer(
//           color: Color(0xff00A1FF),
//           glowColor: Color(0xff00A1FF),
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(60),
//               bottomRight: Radius.circular(60)),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     top: 50, right: 30, left: 30, bottom: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                         onTap: () {},
//                         child: Icon(
//                           Platform.isIOS
//                               ? Icons.arrow_back_ios
//                               : Icons.arrow_back_ios_new,
//                           color: Colors.white,
//                         )),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.calendar_today,
//                           color: Colors.white,
//                         ),
//                         Text(
//                           "7 days",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 25),
//                         ),
//                       ],
//                     ),
//                     Icon(
//                       Icons.more_vert,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width / 2.3,
//                       height: MediaQuery.of(context).size.width / 2.3,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage(tomorrowTemp.image!))),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           "Tomorrow",
//                           style: TextStyle(
//                             fontSize: 30,
//                             height: 0.1,
//                           ),
//                         ),
//                         FittedBox(
//                           child: Container(
//                             // height: constrains.maxHeight * 0.15,
//                             height: constrains.maxWidth * 0.25,
//                             // height: 105,
//                             // color: Colors.redAccent,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 FittedBox(
//                                      child: GlowText(
//                                       tomorrowTemp.max.toString(),
//                                       style: TextStyle(
//                                           fontSize: 100,
//                                           fontWeight: FontWeight.bold),
//                                   ),
//                                    ),
//
//
//                                 AutoSizeText(
//                                   '/' + tomorrowTemp.min.toString() + '\u00B0',
//                                   style: TextStyle(
//                                       color: Colors.black54.withOpacity(0.3),
//                                       fontSize: 40,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//
//                         FittedBox(
//                           child: Text(
//                             tomorrowTemp.name.toString(),
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white70
//                               // color: Colors.black54.withOpacity(0.3)
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Divider(
//                 color: Colors.white70,
//               ),
//               SizedBox(height: 10.0,),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 25),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                         Icon(
//                           CupertinoIcons.wind,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           temp.wind.toString() + " Km/h",
//                           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           "Wind",
//                           style: TextStyle(color: Colors.black54, fontSize: 16),
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Icon(
//                           CupertinoIcons.wind,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           temp.humidity.toString() + " %",
//                           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           "Humidity",
//                           style: TextStyle(color: Colors.black54, fontSize: 16),
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Icon(
//                           CupertinoIcons.wind,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           temp.chanceOfRain.toString() + " %",
//                           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           "Rain",
//                           style: TextStyle(color: Colors.black54, fontSize: 16),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
/*
class SevenDays extends StatelessWidget {
  const SevenDays({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              Text(sevenDays[index].day!, style: TextStyle(fontSize: 20),),
              Container(
                // color: Colors.blue,
                width: 135,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    Image(image: AssetImage(sevenDays[index].image!),width: 40,fit: BoxFit.cover,),
                    SizedBox(
                      width: 15,
                    ),
                    Text(sevenDays[index].name!,
                    style: TextStyle(fontSize: 20,color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Row(
                children:
                [
                  Text("+" + sevenDays[index].max.toString() + "\u00B0", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(width: 5.0,),
                  Text("+" + sevenDays[index].min.toString() + "\u00B0",style: TextStyle(fontSize: 20,color: Colors.grey))
                ],
              )
            ],
          ),
        );
      },
      itemCount: sevenDays.length,),
    );
  }
}

 */

// class ExtraWeather extends StatelessWidget {
//   final WeatherModel temp;
//
//   ExtraWeather(this.temp);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 25),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Column(
//             children: [
//               Icon(
//                 CupertinoIcons.wind,
//                 color: Colors.white,
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 temp.wind.toString() + " Km/h",
//                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 "Wind",
//                 style: TextStyle(color: Colors.black54, fontSize: 16),
//               )
//             ],
//           ),
//           Column(
//             children: [
//               Icon(
//                 CupertinoIcons.wind,
//                 color: Colors.white,
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 temp.humidity.toString() + " %",
//                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 "Humidity",
//                 style: TextStyle(color: Colors.black54, fontSize: 16),
//               )
//             ],
//           ),
//           Column(
//             children: [
//               Icon(
//                 CupertinoIcons.wind,
//                 color: Colors.white,
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 temp.chanceOfRain.toString() + " %",
//                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 "Rain",
//                 style: TextStyle(color: Colors.black54, fontSize: 16),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
