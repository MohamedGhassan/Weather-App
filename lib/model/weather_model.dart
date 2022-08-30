class WeatherModel {
  String? image;
  int? max;
  int? min;
  String? name;
  String? day;
  String? time;
  int? wind;
  int? current;
  String? location;
  int? humidity;
  int? chanceOfRain;

  WeatherModel({this.image,
    this.max,
    this.min,
    this.name,
    this.day,
    this.time,
    this.current,
    this.location,
    this.humidity,
    this.chanceOfRain,
    this.wind});
}

List<WeatherModel> todayWeather = [
  WeatherModel(current: 23, image: 'assets/rainy_2d.png', time: '11.00',),
  WeatherModel(current: 21, image: 'assets/thunder_2d.png', time: '10.00',),
  WeatherModel(current: 22, image: 'assets/rainy_2d.png', time: '12.00',),
  WeatherModel(current: 19, image: 'assets/snow_2d.png', time: '01.00',),
];

  WeatherModel currentTemp = (
  WeatherModel(
      location: 'Gaza',
      name: 'thunderstorm',
      current: 21,
      image: 'assets/thunder.png',
      wind: 13,
      humidity: 24,
      chanceOfRain: 87,
      day: 'Monday, 17 May',
  )
  );

  WeatherModel tomorrowTemp = WeatherModel(
  max: 20,
  min: 17,
  image: "assets/sunny.png",
  name: "Sunny",
  wind: 9,
  humidity: 31,
  chanceOfRain: 20,
);

List<WeatherModel> sevenDays = [
  WeatherModel(day: 'Mon',
      name: 'Rainy',
      max: 20,
      min: 14,
      image: 'assets/rainy_2d.png'),
  WeatherModel(day: 'Tue',
      name: 'Rainy',
      max: 22,
      min: 16,
      image: 'assets/thunder_2d.png'),
  WeatherModel(day: 'Wen',
      name: 'Storm',
      max: 19,
      min: 13,
      image: 'assets/rainy_2d.png'),
  WeatherModel(day: 'Thu',
      name: 'Slow',
      max: 18,
      min: 12,
      image: 'assets/snow_2d.png'),
  WeatherModel(day: 'Fri',
      name: 'Thunder',
      max: 23,
      min: 19,
      image: 'assets/sunny_2d.png'),
  WeatherModel(day: 'Sat',
      name: 'Rainy',
      max: 25,
      min: 17,
      image: 'assets/rainy_2d.png'),
  WeatherModel(day: 'Sun',
      name: 'Storm',
      max: 21,
      min: 18,
      image: 'assets/thunder_2d.png'),

];