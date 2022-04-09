import 'package:brew_crew_app/models/brew.dart';
import 'package:brew_crew_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});
  //creating collection references
  final CollectionReference brewcollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewcollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> brewListSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Brew(
          name: e.get('name') ?? '',
          sugars: e.get('sugars') ?? '0',
          strength: e.get('strength') ?? 0);
    }).toList();
  }

  Stream<List<Brew>> get brewsSnapshot {
    return brewcollection.snapshots().map(brewListSnapshot);
  }

  UserData userDataSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        sugars: snapshot.get('sugars'),
        strength: snapshot.get('strength'));
  }

  //get user doc stream
  Stream<UserData> get userSnapchot {
    return brewcollection.doc(uid).snapshots().map(userDataSnapshot);
  }
}

/*Future<void> createUser({id, mail, userName, photoUrl = ""}) async {
    await _firestore.collection("users").doc(id).set({
      "userName": userName,
      "mail": mail,
      "photoUrl": photoUrl,
      "about": "",
      "createTime": time
    });*/
