import "package:flutter/material.dart";
import 'package:firebase_example/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Update data",
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Name"),
            validator: (value) => value.isEmpty ? "Enter an name" : null,
            onChanged: (value) {
              setState(() => _currentName = value);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _currentSugars ?? '0',
            items: sugars.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text("$e sugars"),
              );
            }).toList(),
            onChanged: (String value) {
              setState(() {
                _currentSugars = value;
              });
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () async {
              print(_currentName);
              print(_currentStrength);
              print(_currentSugars);
            },
            child: Text('Update', style: TextStyle(color: Colors.white)),
            color: Colors.pink[400],
          )
        ],
      ),
    );
  }
}
