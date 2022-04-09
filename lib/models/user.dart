class Users {
  final String id;
  Users({required this.id});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}