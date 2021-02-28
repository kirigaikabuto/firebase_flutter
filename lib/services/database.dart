import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_example/models/brew.dart";
import 'package:firebase_example/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      "strength": strength,
    });
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((e) {
      return Brew(
        name: e.data["name"] ?? "",
        strength: e.data["strength"] ?? 0,
        sugars: e.data["sugars"] ?? "0",
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data["name"],
      strength: snapshot.data["strength"],
      sugars: snapshot.data["sugars"],
    );
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
