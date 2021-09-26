import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:weather/utils/model.dart';

class DataServices {
  static var now = DateTime.now();
  var date = DateFormat('yyyy/MM/dd').format(now);

  static var tomorrowDefault = DateTime(now.year, now.month, now.day + 1);
  var tomorrow = DateFormat('yyyy/MM/dd').format(tomorrowDefault);

  static var dayAfterTomorrowDefault = DateTime(now.year, now.month, now.day + 2);
  var dayAfterTomorrw = DateFormat('yyyy/MM/dd').format(dayAfterTomorrowDefault);

  static const _baseUrl = 'www.metaweather.com';
  static const searchByLocation = 'api/location/search/';

  Future<getWeatherDetails> getWeather(String city) async {

    final queryParameters = {'query': city};
    final url = Uri.https(_baseUrl, searchByLocation, queryParameters);
    var response = await http.get(url);
    var jsonString = response.body;
    List<dynamic> list = json.decode(jsonString);
    var jsonResponse = list.first;

    String title = jsonResponse['title'];
    int woeid = jsonResponse['woeid'];

    getCityWoeid city1 = getCityWoeid(title, woeid);
    final searchByWoeid = '/api/location/$woeid/$date';
    final searchwTom = '/api/location/$woeid/$tomorrow';
    final searchwDayafterTom = '/api/location/$woeid/$dayAfterTomorrw';

    final url2 = Uri.https(_baseUrl, searchByWoeid);
    var response2 = await http.get(url2);
    var jsonStrin = response2.body;

    List<dynamic> list2 = json.decode(jsonStrin);
    var jsonResponse2 = list2.first;

    String weatherStateName = jsonResponse2['weather_state_name'];
    double theTemperature = jsonResponse2['the_temp'];
    int humidity = jsonResponse2['humidity'];
    double airPressure = jsonResponse2['air_pressure'];
    double windSpeed = jsonResponse2['wind_speed'];
    String weatherStateAbbr = jsonResponse2['weather_state_abbr'];
    double minTemp = jsonResponse2['min_temp'];
    double maxTemp = jsonResponse2['max_temp'];

    getWeatherDetails details = getWeatherDetails(
      weatherStateName,
      theTemperature,
      humidity,
      airPressure,
      windSpeed,
      weatherStateAbbr,
      maxTemp,
      minTemp,
    );

    print('details' + details.weatherStateAbbr.toString());
    return details;
  }
}

class getWeatherDetails {
  final String weatherStateName;
  final double theTemperature;
  final int humidity;
  final double airPressure;
  final double windSpeed;
  final String weatherStateAbbr;
  final double minTemp;
  final double maxTemp;

  getWeatherDetails(
      this.weatherStateName,
      this.theTemperature,
      this.humidity,
      this.airPressure,
      this.windSpeed,
      this.weatherStateAbbr,
      this.maxTemp,
      this.minTemp);

  getWeatherDetails.fromJson(Map<String, dynamic> json)
      : weatherStateName = json['weather_state_name'],
        theTemperature = json['the_temp'],
        humidity = json['humidity'],
        airPressure = json['air_pressure'],
        windSpeed = json['wind_speed'],
        weatherStateAbbr = json['weather_state_abbr'],
        minTemp = json['min_temp'],
        maxTemp = json['max_temp'];

  Map<String, dynamic> toJson() => {
        'weather_state_name': weatherStateName,
        'the_temp': theTemperature,
        'humidity': humidity,
        'air_pressure': airPressure,
        'wind_speed': windSpeed,
        'weather_state_abbr': weatherStateAbbr,
        'min_temp': minTemp,
        'max_temp': maxTemp
      };
}

class getCityWoeid {
  final String title;
  final int woeid;

  getCityWoeid(this.title, this.woeid);

  getCityWoeid.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        woeid = json['woied'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'woied': woeid,
      };
}
