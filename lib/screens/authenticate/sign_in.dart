import 'package:firebase_example/services/auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: Text("Login"),
            actions: [
              FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text("Register"))
            ]),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                child: Column(children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() => email = value);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                  onPressed: () async {
                    print(email);
                    print(password);
                  },
                  color: Colors.pink[400],
                  child: Text("Sing in",
                      style: TextStyle(
                        color: Colors.white,
                      )))
            ]))));
  }
}
