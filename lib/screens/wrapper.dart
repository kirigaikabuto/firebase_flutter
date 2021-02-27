import 'package:firebase_example/models/user.dart';
import 'package:firebase_example/screens/authenticate/authenticate.dart';
import "package:flutter/material.dart";
import "package:firebase_example/screens/home/home.dart";
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    }
    return Home();
  }
}
