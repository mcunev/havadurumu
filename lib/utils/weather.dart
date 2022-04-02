import 'dart:convert';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:html/parser.dart';
import 'package:http/http.dart';
//import 'package:location/location.dart';

import 'location.dart';

class WeatherDisplaydata {
  Icon weatherIcon;

  AssetImage weatherImage;

  WeatherDisplaydata({required this.weatherIcon, required this.weatherImage});
}

const apiKey = "ae4444db6ce999e79381ea4791f0db45";

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  late double curretTemperature;
  late int currentCondition;
  late String country;
  late String cityName;
  late String lan = locationData.latitude.toString();
  late String lon = locationData.longitude.toString();
  late String a =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lan&lon=$lon&appid=$apiKey&units=metric";

  Future<void> getCurrentTemperature(
      {required String lan, required String lon}) async {
    Response response = await get(Uri.parse(a));
    //print(response.toString());
    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);
      // print('başarılı');
      try {
        curretTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        country = currentWeather['sys']['country'];
        cityName = currentWeather['name'];
      } catch (e) {
        //print(e);
      }
    } else {
      //print(' Apinden değer gelmiyor');
    }
  }

  WeatherDisplaydata getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplaydata(
          weatherIcon:
              const Icon(FontAwesomeIcons.cloud, size: 75, color: Colors.white),
          weatherImage: const AssetImage('assets/bulutlu.png'));
    } else {
      // Hava iyi
      // Gece Gündüz kontrolü
      var now = DateTime.now();
      if (now.hour >= 19) {
        //akşam
        return WeatherDisplaydata(
            weatherIcon: const Icon(FontAwesomeIcons.moon,
                size: 75, color: Colors.white),
            weatherImage: const AssetImage('assets/gece.png'));
      } else {
        return WeatherDisplaydata(
            weatherIcon:
                const Icon(FontAwesomeIcons.sun, size: 75, color: Colors.white),
            weatherImage: const AssetImage('assets/gunesli.png'));
      }
    }
  }
}
