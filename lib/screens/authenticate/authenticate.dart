import 'package:firebase_example/screens/authenticate/register.dart';
import 'package:firebase_example/screens/authenticate/sign_in.dart';
import "package:flutter/material.dart";

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool shownSignIn = true;

  void toggleView() {
    setState(() => shownSignIn = !shownSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (shownSignIn) {
      return SignIn(toggleView: toggleView);
    }
    return Register(toggleView: toggleView);
  }
}
