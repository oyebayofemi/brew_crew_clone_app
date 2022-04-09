import 'package:brew_crew_app/services/auth.dart';
import 'package:brew_crew_app/shared/loading.dart';
import 'package:brew_crew_app/shared/text_decoration.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;

  RegisterPage({required this.toggleView});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();

  //Creating email state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

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
              actions: [
                FlatButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 17,
                      ),
                    ))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Register',
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            // print(email);
                            // print(password);

                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.registerUser(email, password);

                              if (result == null) {
                                setState(() {
                                  error = 'Please supply a valid email';
                                  loading = false;
                                });
                              }
                            }
                          },
                          color: Colors.pink[400],
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                        ),
                      ],
                    )),
              ),
            ),
          );
  }
}
