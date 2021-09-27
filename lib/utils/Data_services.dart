import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weather/utils/FutureWeather.dart';
import 'package:weather/utils/GetWeatherDetails.dart';

class DataServices {
  static var now = DateTime.now();
  var date = DateFormat('yyyy/MM/dd').format(now);

  static var tomorrowDefault = DateTime(now.year, now.month, now.day + 1);
  var tomorrow = DateFormat('yyyy/MM/dd').format(tomorrowDefault);

  static var dayAfterTomorrowDefault =
      DateTime(now.year, now.month, now.day + 2);
  var dayAfterTomorrw =
      DateFormat('yyyy/MM/dd').format(dayAfterTomorrowDefault);

  static const _baseUrl = 'www.metaweather.com';
  static const searchByLocation = 'api/location/search/';

  Future<FutureWeather> getFutureWeather(String city) async {
    final queryParameters = {'query': city};
    final url = Uri.https(_baseUrl, searchByLocation, queryParameters);
    var response = await http.get(url);
    var jsonString = response.body;
    List<dynamic> list = json.decode(jsonString);
    var jsonResponse = list.first;
    int woeid = jsonResponse['woeid'];
    final searchForTomorrow = '/api/location/$woeid/$tomorrow';

    //tomorrow
    final url3 = Uri.https(_baseUrl, searchForTomorrow);
    var responseOutput3 = await http.get(url3);
    var jsonOutput3 = responseOutput3.body;
    List<dynamic> listOutput3 = json.decode(jsonOutput3);
    var jsonObject3 = listOutput3.first;

    String weatherStateAbbrTomorrow = jsonObject3['weather_state_abbr'];
    double minTempTomorrow = jsonObject3['min_temp'];
    double maxTempTomorrow = jsonObject3['max_temp'];

    FutureWeather futureWeather = FutureWeather(
        weatherStateAbbrTomorrow, maxTempTomorrow, minTempTomorrow);

    print(futureWeather.weatherStateAbbr);
    return futureWeather;
  }

  Future<FutureWeather> getFutureMost(String city) async {
    final queryParameters = {'query': city};
    final url = Uri.https(_baseUrl, searchByLocation, queryParameters);
    var response = await http.get(url);
    var jsonString = response.body;
    List<dynamic> list = json.decode(jsonString);
    var jsonResponse = list.first;
    int woeid = jsonResponse['woeid'];
    final searchForDayafterTom = '/api/location/$woeid/$dayAfterTomorrw';

    //dayaftertomorrow
    final url4 = Uri.https(_baseUrl, searchForDayafterTom);
    var responseOutput4 = await http.get(url4);
    var jsonOutput4 = responseOutput4.body;
    List<dynamic> listOutput4 = json.decode(jsonOutput4);
    var jsonObject4 = listOutput4.first;

    String weatherStateAbbrTomorrow = jsonObject4['weather_state_abbr'];
    double minTempTomorrow = jsonObject4['min_temp'];
    double maxTempTomorrow = jsonObject4['max_temp'];

    FutureWeather futureMost = FutureWeather(
        weatherStateAbbrTomorrow, maxTempTomorrow, minTempTomorrow);

    print(futureMost.weatherStateAbbr);
    return futureMost;
  }

  Future<GetWeatherDetails> getWeather(String city) async {
    final queryParameters = {'query': city};
    final url = Uri.https(_baseUrl, searchByLocation, queryParameters);
    var response = await http.get(url);
    var jsonString = response.body;
    List<dynamic> list = json.decode(jsonString);
    var jsonResponse = list.first;
    int woeid = jsonResponse['woeid'];

    final searchByWoeid = '/api/location/$woeid/$date';

    //today
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

    print(details.weatherStateAbbr);
    return details;
  }
}
