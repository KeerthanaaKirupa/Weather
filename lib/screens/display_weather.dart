import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:weather/screens/conversion.dart';
import 'package:weather/utils/data_services.dart';
import 'package:intl/intl.dart';

class DisplayWeather extends StatefulWidget {
  final String city;
  const DisplayWeather(this.city);

  @override
  _DisplayWeatherState createState() => _DisplayWeatherState();
}

class _DisplayWeatherState extends State<DisplayWeather> {
  static var now = DateTime.now();
  var day = DateFormat('EEEE').format(now);
  UnitConversion unitCon = UnitConversion();

  String temperature;
  Future<getWeatherDetails> future;
  DataServices ds = DataServices();
  bool unit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Weather Report'),
            IconButton(icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute<UnitConversion>(
                  builder: (context) => UnitConversion(),
                ),
              );
            },
            ),
          ],
        ),
      ),
      body: FutureBuilder<getWeatherDetails>(
        future: ds.getWeather(widget.city),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  day,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  snapshot.data.weatherStateName,
                  style: TextStyle(fontSize: 30),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 300,
                    height: 300,
                    child: Image.asset(
                      getImage(snapshot.data.weatherStateAbbr),
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
                Text(
                  snapshot.data.theTemperature.toStringAsFixed(2) + ' °C',
                  style: TextStyle(fontSize: 30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDivider(),
                    Text(
                      'Humidity: ' + snapshot.data.humidity.toString() + ' %',
                    ),
                    buildDivider(),
                    Text(
                      'Air pressure: ' +
                          snapshot.data.airPressure.toString() +
                          ' mb',
                    ),
                    buildDivider(),
                    Text(
                      'wind Speed: ' +
                          snapshot.data.windSpeed.toStringAsFixed(2) +
                          ' kph',
                    ),
                    buildDivider(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.purple),
                        ),
                        child: Column(children: [
                          Text(
                            day,
                          ),
                          Expanded(
                            child: Image.asset(
                              getImage(snapshot.data.weatherStateAbbr),
                            ),
                          ),
                          Text(snapshot.data.minTemp.toStringAsFixed(0) +
                              '/' +
                              snapshot.data.maxTemp.toStringAsFixed(0)),
                        ]),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.purple),
                        ),
                        child: Column(children: [
                          Expanded(
                            child: Image.asset(
                              getImage(snapshot.data.weatherStateAbbr),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.purple),
                        ),
                        child: Column(children: [
                          Expanded(
                            child: Image.asset(
                              getImage(snapshot.data.weatherStateAbbr),
                            ),
                          ),
                          Text('12/!4'),
                        ]),
                      ),
                    ])
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 15,
      thickness: 2,
    );
  }

  String getImage(String weatherStateAbbr) {
    var _bg;
    String abbr = weatherStateAbbr;

    if (abbr == 'hr') {
      _bg = 'assets/heavyrain.png';
    } else if (abbr == 'sl') {
      _bg = 'assets/sleet.png';
    } else if (abbr == 'sn') {
      _bg = 'assets/snow.png';
    } else if (abbr == 'h') {
      _bg = 'assets/hail.png';
    } else if (abbr == 'c') {
      _bg = 'assets/clear.png';
    } else if (abbr == 'hc') {
      _bg = 'assets/heavycloud.png';
    } else if (abbr == 's' || abbr == 'lr') {
      _bg = 'assets/showers.png';
    } else if (abbr == 'lc') {
      _bg = 'assets/lightcloud.png';
    } else if (abbr == 'ts') {
      _bg = 'assets/thunferstorm.png';
    } else {
      _bg = 'assets/default.png';
    }

    return _bg;
  }
}
