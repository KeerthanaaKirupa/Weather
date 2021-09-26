import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class UnitConversion extends StatelessWidget {
  bool isCelsius = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converison'),
      ),
      body: Row(
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: ListTile(
                 title: Text("Temperature Units ('°F')"),
                trailing:
                    GFToggle(
                      onChanged: (val){
                      },
                      value: true,
                      enabledThumbColor: Colors.purple,
                      enabledTrackColor: Colors.purple[100],
                      type: GFToggleType.square,
                    ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
