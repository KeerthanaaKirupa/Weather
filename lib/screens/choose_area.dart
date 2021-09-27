import 'package:flutter/material.dart';
import 'package:weather/screens/display_weather.dart';

class ChooseArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController inputController = TextEditingController();
    String labelText = 'City';
    UnderlineInputBorder underlineInputBorder =
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black));
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your City'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: validateTextInput,
                controller: inputController,
                decoration: InputDecoration(
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
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<DisplayWeather>(
                        builder: (context) =>
                            DisplayWeather(inputController.text),
                      ),
                    );
                  }
                },
                child: Text('Continue'))
          ],
        ),
      ),
    );
  }

  String validateTextInput(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a City Name';
    } else {
      return null;
    }
  }
}
