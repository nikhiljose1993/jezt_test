import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/model/weather_data_modal.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test/service/location_service.dart';

class WeatherDataNotifier extends StateNotifier<WeatherData> {
  WeatherDataNotifier()
      : super(WeatherData(
          lon: 0.0,
          lat: 0.0,
          weatherId: 0,
          weatherMain: '',
          weatherDescription: '',
          weatherIcon: '',
          base: '',
          temp: 0.0,
          feelsLike: 0.0,
          tempMin: 0.0,
          tempMax: 0.0,
          pressure: 0,
          humidity: 0,
          visibility: 0,
          windSpeed: 0.0,
          windDeg: 0,
          rain1h: 0.0,
          cloudsAll: 0,
          dt: 0,
          sysType: 0,
          sysId: 0,
          sysCountry: '',
          sysSunrise: 0,
          sysSunset: 0,
          timezone: 0,
          id: 0,
          name: '',
          cod: 0,
        ));

  Future<bool> fetchWeatherData() async {
    final apiKey = dotenv.env['WEATHER_API_KEY'];
    final Position location = await LocationService().determinePosition();

    final lat = location.latitude.toString();
    final long = location.longitude.toString();

    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&appid=$apiKey'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // print(data);
        final WeatherData weatherData = WeatherData.fromJson(data);
        // print(weatherData.feelsLike);
        state = weatherData;
        return false;
      } else {
        // state = {};
        return true;
      }
    } catch (e) {
      // state = {};
      return true;
    }
  }
}

final weatherDataProvider =
    StateNotifierProvider<WeatherDataNotifier, WeatherData>(
  (ref) => WeatherDataNotifier(),
);
