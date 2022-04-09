import 'package:brew_crew_app/models/brew.dart';
import 'package:brew_crew_app/screens/home/brew_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brew = Provider.of<List<Brew>?>(context) ?? [];
    //print(brew.docs);
    // for (var lists in brew!.docs) {
    //   print(lists.data());
    // }

    // brew.forEach((e) {
    //   print(e.name);
    //   print(e.strength);
    //   print(e.sugars);
    // });
    return ListView.builder(
      itemCount: brew.length,
      itemBuilder: (context, index) {
        return BrewTitle(brew: brew[index]);
      },
    );
  }
}
