import 'package:brew_crew_app/models/brew.dart';
import 'package:brew_crew_app/screens/home/brew_list.dart';
import 'package:brew_crew_app/screens/home/edit_form.dart';
import 'package:brew_crew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_app/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void showEditPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: EditForm(),
          );
        },
      );
    }

    final AuthService _auth = AuthService();
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brewsSnapshot,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Brew Crew',
            style: TextStyle(color: Colors.brown),
          ),
          elevation: 0,
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          actions: [
            FlatButton.icon(
              onPressed: () {
                showEditPanel();
              },
              icon: Icon(Icons.edit),
              label: Text('Edit'),
              textColor: Colors.brown,
            ),
            FlatButton.icon(
              textColor: Colors.brown,
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.exit_to_app),
              label: Text('Logout'),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/coffee_bg.png',
                    ),
                    fit: BoxFit.cover)),
            child: BrewList()),
      ),
    );
  }
}
