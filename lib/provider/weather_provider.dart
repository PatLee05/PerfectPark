import 'package:flutter/material.dart';
import 'package:park_locator/helper/weather_condition.dart';

class WeatherProvider extends ChangeNotifier {
  int tempInFarenheit = 0;
  WeatherCondition condition = WeatherCondition.unknown;
  bool update = false;

  updateWeather(int newTempFarenheit, WeatherCondition newCondition){
    tempInFarenheit = newTempFarenheit;
    condition = newCondition;
    update = true;
    notifyListeners();
  }

  bool get hasUpdated {
    return update;
  }
}