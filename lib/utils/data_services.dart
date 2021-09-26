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

    print('details' + details.weatherStateAbbr.toString());
    return details;
  }
}


