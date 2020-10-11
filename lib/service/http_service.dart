import 'dart:convert';
import 'dart:io';

import 'package:izmir_weather/model/weather.dart';
import 'package:http/http.dart' as http;

Weather weather;

class HttpWeatherService {
  final baseUrl = "https://www.metaweather.com/api/location/2344117";
  Weather weatherData;
  Future<Weather> get getHttp async {
    var response = await http.get(baseUrl);
    switch (response.statusCode) {
      case HttpStatus.ok:
        var jsonBody = jsonDecode(response.body);
        return weather = Weather.fromJson(jsonBody);
        break;
      default:
    }
  }
}
