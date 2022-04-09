import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/services/auth.dart';
import 'package:brew_crew_app/shared/loading.dart';
import 'package:brew_crew_app/shared/text_decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;

  SignInPage({required this.toggleView});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  //Creating email state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.pink[400],
                                fontWeight: FontWeight.w500,
                                fontSize: 45),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              print('Field must not be empty');
                              return ('Field must not be empty');
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: textInputDecoration().copyWith(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.mail),
                              focusColor: Colors.pink),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              print('Field must not be empty');
                              return ('Field must not be empty');
                            } else if (value.length < 6) {
                              print(
                                  'Password must not be less than 6 characters');
                              return ('Password must not be less than 6 characters');
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: textInputDecoration().copyWith(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            //calling the validate method
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.signInUser(email, password);

                              if (result == null) {
                                setState(() {
                                  error = 'Wrong Username or password';
                                  loading = false;
                                });
                              }
                            }
                          },
                          color: Colors.pink[400],
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                        ),
                        Text('I dont have an account?'),
                        FlatButton(
                            onPressed: () {
                              widget.toggleView();
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.pink,
                              ),
                            ))
                      ],
                    )),
              ),
            ),
          );
  }
}
