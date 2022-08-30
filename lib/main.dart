import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:weather/screen/details_screen.dart';
import 'package:weather/screen/weather_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    DevicePreview(
      builder: (context) => MyApp(),
    enabled: !kReleaseMode,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // builder: (context, child) {
        //   return ResponsiveWrapper.builder(
        //       child, maxWidth: 1200, minWidth: 480, defaultScale: true,breakpoints:
        //   [
        //     ResponsiveBreakpoint.resize(480, name: MOBILE),
        //     ResponsiveBreakpoint.autoScale(800, name: TABLET),
        //     ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        //   ],
        //   );
        // },
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.blue,
                )),
        debugShowCheckedModeBanner: false,
        home: WeatherScreen());
  }
}
