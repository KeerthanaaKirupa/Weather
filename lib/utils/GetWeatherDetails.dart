class GetWeatherDetails {
  final String weatherStateName;
  final double theTemperature;
  final int humidity;
  final double airPressure;
  final double windSpeed;
  final String weatherStateAbbr;
  final double minTemp;
  final double maxTemp;

  GetWeatherDetails(
      this.weatherStateName,
      this.theTemperature,
      this.humidity,
      this.airPressure,
      this.windSpeed,
      this.weatherStateAbbr,
      this.maxTemp,
      this.minTemp);

  GetWeatherDetails.fromJson(Map<String, dynamic> json)
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