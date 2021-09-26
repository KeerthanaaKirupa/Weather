import 'package:flutter/material.dart';
import 'package:weather/screens/conversion.dart';
import 'package:weather/screens/display_weather.dart';
import 'package:weather/utils/data_services.dart';
import 'package:weather/utils/model.dart';

class ChooseArea extends StatelessWidget {
  final _dataservice = DataServices();
  TextEditingController inputController = TextEditingController();
  String labelText = 'City';
  UnderlineInputBorder underlineInputBorder =
  UnderlineInputBorder(borderSide: BorderSide(color: Colors.black));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your City'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: inputController,
              decoration:InputDecoration(
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 0,
                  minWidth: 0,
                ),
                helperText: 'Example: Chennai',
                labelText: labelText.toUpperCase(),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  height: 1,
                ),
                focusedBorder: underlineInputBorder,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _search();
                Navigator.push(
                  context,
                  MaterialPageRoute<DisplayWeather>(
                    builder: (context) => DisplayWeather(inputController.text),
                  ),
                );
              },
              child: Text('Continue'))
        ],
      ),
    );
  }


  void _search() async {
    final response = await _dataservice.getWeather(inputController.text);
   // print(response.weatherStateName);
  }
}