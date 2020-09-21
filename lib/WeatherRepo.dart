import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/WeatherModel.dart';

class WeatherRepo {
  Future<WeatherModel> getWeather(String city) async {
    final String url =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=140d4b2928deaa7118ad35110bcbc50c&units=metric";

    final result = await http.Client().get(url);

    if (result.statusCode != 200) throw Exception();

    return parseJSON(result.body);
  }

  WeatherModel parseJSON(final response) {
    final jsonDecoded = json.decode(response);
    final result = {'name': jsonDecoded["name"]};
    final jsonWeather = jsonDecoded["main"];
    result.addAll(jsonWeather);
    print(WeatherModel.fromJson(result));

    return WeatherModel.fromJson(result);
  }
}
