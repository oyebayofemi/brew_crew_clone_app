import 'package:brew_crew_app/screens/authenticate/register.dart';
import 'package:brew_crew_app/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  //changing the showSignIn to false
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignInPage(toggleView: toggleView)
        : RegisterPage(toggleView: toggleView);
  }
}
