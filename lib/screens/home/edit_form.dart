import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/services/database.dart';
import 'package:brew_crew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_app/shared/text_decoration.dart';
import 'package:provider/provider.dart';

class EditForm extends StatefulWidget {
  EditForm({Key? key}) : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugar;
  late final int _currentStrengths;
  final bool strFlag = true;

  @override
  Widget build(BuildContext context) {
    final userChecker = Provider.of<Users?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: userChecker!.id).userSnapchot,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            int strength = userData!.strength;
            String name = userData.name;
            String sugarss = userData.sugars;

            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: name,
                    decoration:
                        textInputDecoration().copyWith(hintText: 'Enter Name '),
                    onChanged: (value) {
                      _currentName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('Field cant be empty. Please enter a name');
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: textInputDecoration(),
                    value: sugarss,
                    //xhint: Text('Select the number of sugars'),
                    items: sugars.map((e) {
                      return DropdownMenuItem(
                          value: e, child: Text('$e sugars'));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _currentSugar = value.toString();
                      });
                    },
                  ),
                  Slider(
                    value: (strFlag ? strength : _currentStrengths).toDouble(),
                    activeColor:
                        Colors.brown[strFlag ? strength : _currentStrengths],
                    inactiveColor:
                        Colors.brown[(strFlag ? strength : _currentStrengths)],
                    onChanged: (value) {
                      setState(() {
                        _currentStrengths = value.round();
                      });
                    },
                    max: 900,
                    min: 100,
                    divisions: 8,
                  ),
                  FlatButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await DatabaseService(uid: userData.uid).updateUserData(
                            _currentSugar ?? sugarss,
                            _currentName ?? name,
                            _currentStrengths);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Update'),
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
