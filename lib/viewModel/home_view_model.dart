import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:izmir_weather/model/weather.dart';
import 'package:izmir_weather/service/http_service.dart';
import '../view/home.dart';
import 'package:http/http.dart' as http;

abstract class HomeViewModel extends State<Home> {
  // Add your state and logic here

  var http_deneme = HttpWeatherService();
}
