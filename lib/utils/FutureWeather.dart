class FutureWeather {
  final String weatherStateAbbr;
  final double minTemp;
  final double maxTemp;

  FutureWeather(this.weatherStateAbbr,
      this.maxTemp,
      this.minTemp);

  FutureWeather.fromJson(Map<String, dynamic> json)
      : weatherStateAbbr = json['weather_state_abbr'],
        minTemp = json['min_temp'],
        maxTemp = json['max_temp'];


  Map<String, dynamic> toJson() => {
    'weather_state_abbr': weatherStateAbbr,
    'min_temp': minTemp,
    'max_temp': maxTemp
  };

}