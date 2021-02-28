import 'package:firebase_example/models/user.dart';
import 'package:firebase_example/services/database.dart';
import "package:flutter/material.dart";
import 'package:firebase_example/shared/constants.dart';
import "package:provider/provider.dart";
import 'package:firebase_example/shared/loading.dart';

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
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uuid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
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
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText: "Name"),
                    validator: (value) =>
                        value.isEmpty ? "Enter an name" : null,
                    onChanged: (value) {
                      setState(() => _currentName = value);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
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
                  Slider(
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) {
                      setState(() {
                        _currentStrength = val.round();
                      });
                    },
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uuid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                      }
                      Navigator.pop(context);
                    },
                    child:
                        Text('Update', style: TextStyle(color: Colors.white)),
                    color: Colors.pink[400],
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
