import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/utils/images.dart';

class WeatherFullView extends StatefulWidget {
  final String day;
  final double minTemp;
  final double maxTemp;
  final bool unit;
  final String weatherStateAbbr;

  const WeatherFullView(this.day, this.minTemp, this.maxTemp, this.unit, this.weatherStateAbbr);

  @override
  _WeatherFullViewState createState() => _WeatherFullViewState();
}

class _WeatherFullViewState extends State<WeatherFullView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full-Screen View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.day, style: TextStyle(fontSize: 30),
            ),
            Expanded(
              child: Image.asset(
                Images.getImage(widget.weatherStateAbbr),
              ),
            ),
            Text(
              widget.unit
                  ? widget.minTemp.toStringAsFixed(0) +
                  '/' +
                  widget.maxTemp.toStringAsFixed(0)
                  : (widget.minTemp * 1.8 + 32)
                  .toStringAsFixed(0) +
                  '/' +
                  (widget.maxTemp * 1.8 + 32)
                      .toStringAsFixed(0),
              style: TextStyle(fontSize: 50) ,
            ),
          ],
        ),
      ),
    );
  }

}
