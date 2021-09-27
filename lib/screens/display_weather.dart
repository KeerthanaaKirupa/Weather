import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather/screens/weather_full_view.dart';
import 'package:weather/utils/Data_services.dart';
import 'package:intl/intl.dart';
import 'package:weather/utils/FutureWeather.dart';
import 'package:weather/utils/GetWeatherDetails.dart';
import 'package:getwidget/getwidget.dart';
import 'package:weather/utils/images.dart';

import '../utils/GetWeatherDetails.dart';

class DisplayWeather extends StatefulWidget {
  final String city;
  const DisplayWeather(this.city);

  @override
  _DisplayWeatherState createState() => _DisplayWeatherState();
}

class _DisplayWeatherState extends State<DisplayWeather> {
  static var now = DateTime.now();
  var day = DateFormat('EEEE').format(now);

  static var tomorrowDefault = DateTime(now.year, now.month, now.day + 1);
  var tomorrow = DateFormat('EEEE').format(tomorrowDefault);

  static var dayAfterTomorrowDefault =
      DateTime(now.year, now.month, now.day + 2);
  var dayAfterTomorrow = DateFormat('EEEE').format(dayAfterTomorrowDefault);

  String temperature;
  Future<GetWeatherDetails> future;
  DataServices dataService = DataServices();
  bool unit = true;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Weather Report'),
            Container(
              child: Row(
                children: [
                  GFToggle(
                    onChanged: (val) {
                      setState(() {
                        unit = !unit;
                      });
                    },
                    value: false,
                    enabledThumbColor: Colors.purple,
                    enabledTrackColor: Colors.purple[100],
                    type: GFToggleType.square,
                  ),
                  Text('°F'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<GetWeatherDetails>(
        future: dataService.getWeather(widget.city),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildSizedBox(),
                Text(
                  day,
                  style: TextStyle(fontSize: 20),
                ),
                buildSizedBox(),
                Text(
                  snapshot.data.weatherStateName,
                  style: TextStyle(fontSize: 30),
                ),
                buildExpandedImage(snapshot),
                Text(
                  unit
                      ? (snapshot.data.theTemperature.toStringAsFixed(2) +
                          '°C')
                      : (snapshot.data.theTemperature * 1.8 + 32)
                              .toStringAsFixed(2) +
                          '°F',
                  style: TextStyle(fontSize: 30),
                ),
                buildMoreDetailsColumn(snapshot),
                buildSizedBox(),
                weatherForThreeDays(snapshot),
                buildSizedBox()
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Row weatherForThreeDays(AsyncSnapshot<GetWeatherDetails> snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FutureBuilder<GetWeatherDetails>(
          future: dataService.getWeather(widget.city),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<WeatherFullView>(
                      builder: (context) => WeatherFullView(
                          day,
                          snapshot.data.minTemp,
                          snapshot.data.maxTemp,
                          unit,
                          snapshot.data.weatherStateAbbr),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: boxDecoration(),
                  child: Column(
                    children: [
                      Text(
                        day,
                      ),
                      Expanded(
                        child: Image.asset(
                          Images.getImage(snapshot.data.weatherStateAbbr),
                        ),
                      ),
                      Text(
                        unit
                            ? snapshot.data.minTemp.toStringAsFixed(0) +
                                '/' +
                                snapshot.data.maxTemp.toStringAsFixed(0)
                            : (snapshot.data.minTemp * 1.8 + 32)
                                    .toStringAsFixed(0) +
                                '/' +
                                (snapshot.data.maxTemp * 1.8 + 32)
                                    .toStringAsFixed(0),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        FutureBuilder<FutureWeather>(
          future: dataService.getFutureWeather(widget.city),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<WeatherFullView>(
                      builder: (context) => WeatherFullView(
                          tomorrow,
                          snapshot.data.minTemp,
                          snapshot.data.maxTemp,
                          unit,
                          snapshot.data.weatherStateAbbr),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: boxDecoration(),
                  child: Column(
                    children: [
                      Text(
                        tomorrow,
                      ),
                      Expanded(
                        child: Image.asset(
                          Images.getImage(snapshot.data.weatherStateAbbr),
                        ),
                      ),
                      Text(
                        unit
                            ? snapshot.data.minTemp.toStringAsFixed(0) +
                                '/' +
                                snapshot.data.maxTemp.toStringAsFixed(0)
                            : (snapshot.data.minTemp * 1.8 + 32)
                                    .toStringAsFixed(0) +
                                '/' +
                                (snapshot.data.maxTemp * 1.8 + 32)
                                    .toStringAsFixed(0),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        FutureBuilder<FutureWeather>(
            future: dataService.getFutureMost(widget.city),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<WeatherFullView>(
                        builder: (context) => WeatherFullView(
                            dayAfterTomorrow,
                            snapshot.data.minTemp,
                            snapshot.data.maxTemp,
                            unit,
                            snapshot.data.weatherStateAbbr),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: boxDecoration(),
                    child: Column(
                      children: [
                        Text(dayAfterTomorrow),
                        Expanded(
                          child: Image.asset(
                            Images.getImage(snapshot.data.weatherStateAbbr),
                          ),
                        ),
                        Text(
                          unit
                              ? snapshot.data.minTemp.toStringAsFixed(0) +
                                  '/' +
                                  snapshot.data.maxTemp.toStringAsFixed(0)
                              : (snapshot.data.minTemp * 1.8 + 32)
                                      .toStringAsFixed(0) +
                                  '/' +
                                  (snapshot.data.maxTemp * 1.8 + 32)
                                      .toStringAsFixed(0),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ],
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2, color: Colors.purple),
    );
  }

  Column buildMoreDetailsColumn(AsyncSnapshot<GetWeatherDetails> snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDivider(),
        Text(
          'Humidity: ' + snapshot.data.humidity.toString() + ' %',
        ),
        buildDivider(),
        Text(
          'Air pressure: ' + snapshot.data.airPressure.toString() + ' mb',
        ),
        buildDivider(),
        Text(
          'wind Speed: ' + snapshot.data.windSpeed.toStringAsFixed(2) + ' kph',
        ),
        buildDivider(),
      ],
    );
  }

  Expanded buildExpandedImage(AsyncSnapshot<GetWeatherDetails> snapshot) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          height: 300,
          child: Image.asset(
            Images.getImage(snapshot.data.weatherStateAbbr),
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 10,
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 15,
      thickness: 2,
    );
  }

}
