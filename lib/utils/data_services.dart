import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weather/utils/GetWeatherDetails.dart';

class DataServices {
  static var now = DateTime.now();
  var date = DateFormat('yyyy/MM/dd').format(now);

  static var tomorrowDefault = DateTime(now.year, now.month, now.day + 1);
  var tomorrow = DateFormat('yyyy/MM/dd').format(tomorrowDefault);

  static var dayAfterTomorrowDefault = DateTime(now.year, now.month, now.day + 2);
  var dayAfterTomorrw = DateFormat('yyyy/MM/dd').format(dayAfterTomorrowDefault);

  static const _baseUrl = 'www.metaweather.com';
  static const searchByLocation = 'api/location/search/';

  Future<GetWeatherDetails> getWeather(String city) async {

    final queryParameters = {'query': city};
    final url = Uri.https(_baseUrl, searchByLocation, queryParameters);
    var response = await http.get(url);
    var jsonString = response.body;
    List<dynamic> list = json.decode(jsonString);
    var jsonResponse = list.first;
    int woeid = jsonResponse['woeid'];

    final searchByWoeid = '/api/location/$woeid/$date';
    final searchForTomorrow = '/api/location/$woeid/$tomorrow';
    final searchForDayafterTom = '/api/location/$woeid/$dayAfterTomorrw';

    final url2 = Uri.https(_baseUrl, searchByWoeid);
    var responseOutput = await http.get(url2);
    var jsonOutput = responseOutput.body;

    List<dynamic> listOutput = json.decode(jsonOutput);
    var jsonObject = listOutput.first;

    String weatherStateName = jsonObject['weather_state_name'];
    double theTemperature = jsonObject['the_temp'];
    int humidity = jsonObject['humidity'];
    double airPressure = jsonObject['air_pressure'];
    double windSpeed = jsonObject['wind_speed'];
    String weatherStateAbbr = jsonObject['weather_state_abbr'];
    double minTemp = jsonObject['min_temp'];
    double maxTemp = jsonObject['max_temp'];

    GetWeatherDetails details = GetWeatherDetails(
      weatherStateName,
      theTemperature,
      humidity,
      airPressure,
      windSpeed,
      weatherStateAbbr,
      maxTemp,
      minTemp,
    );

    return details;
  }
}


