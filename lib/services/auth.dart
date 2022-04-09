import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Creating method to signin anonymously
  //creating user object based on firebase user
  Users? _userData(User user) {
    return user != null ? Users(id: user.uid) : null;
  }

  Stream<Users?> get userChecker {
    return _auth.authStateChanges().map((User? user) => _userData(user!));
    //.map(_userData);
  }

  Future registerUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'New  Crew Member', 100);
      return _userData(user);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future signInUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userData(user!);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future signInAnnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userData(user!);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
