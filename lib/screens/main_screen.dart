import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havadurumu/utils/weather.dart';
//import 'package:http/http.dart';
//import 'package:location/location.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.weatherData}) : super(key: key);
  final WeatherData weatherData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late Text temperatureText;
  late String country;
  late String cityName;
  late Text locationText;
  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.curretTemperature.round();
      cityName = weatherData.cityName;
      country = weatherData.country;
      WeatherDisplaydata weatherDisplaydata =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplaydata.weatherImage;
      weatherDisplayIcon = weatherDisplaydata.weatherIcon;
      locationText = Text(cityName + '/' + country,
          style: const TextStyle(
              color: Colors.white, fontSize: 80.0, letterSpacing: -5));
      temperatureText = Text(
        '$temperature°',
        style: const TextStyle(
            color: Colors.white, fontSize: 80.0, letterSpacing: -5),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: backgroundImage,
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.all(1),
              child: weatherDisplayIcon,
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: temperatureText,
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: locationText,
            )
          ],
        ),
      ),
    );
  }
}
