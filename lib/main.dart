import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/screens/wrapper.dart';
import 'package:brew_crew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: AuthService().userChecker,
      initialData: null,
      catchError: (User, Users) => null,
      child: MaterialApp(home: Wrapper()),
    );
  }
}
