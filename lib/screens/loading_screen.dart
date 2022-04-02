import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:havadurumu/screens/main_screen.dart';
import 'package:havadurumu/utils/location.dart';
import 'package:havadurumu/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      // print('konum bilgileri gelmiyor');
    } else {
      // print('Latiude: ' + locationData.latitude.toString());
      // print('Longitude: ' + locationData.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature(
        lan: locationData.latitude.toString(),
        lon: locationData.longitude.toString());

    if (weatherData.curretTemperature == null ||
        weatherData.currentCondition == null) {
      // print("Apiden sıcaklık verya durum bilgisi boş dönüyor");
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MainScreen(
          weatherData: weatherData,
        );
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade400, Colors.purpleAccent])),
      child: const Center(
          child: SpinKitPouringHourGlassRefined(
        color: Colors.white,
        size: 150.0,
        duration: Duration(milliseconds: 1200),
      )),
    ));
  }
}
