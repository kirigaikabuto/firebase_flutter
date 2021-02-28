import 'package:firebase_example/services/auth.dart';
import 'package:firebase_example/shared/loading.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:firebase_example/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Email"),
                        validator: (value) =>
                            value.isEmpty ? "Enter an email" : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "Password"),
                        validator: (value) => value.length < 6
                            ? "Enter a password 6+ chars long"
                            : null,
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
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.signInWithEmailAndPasswordMethod(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      "No user with that email and password";
                                  loading = false;
                                });
                              } else {}
                            }
                          },
                          color: Colors.pink[400],
                          child: Text("Sing in",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                      SizedBox(height: 20.0),
                      Text(error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0))
                    ]))));
  }
}
