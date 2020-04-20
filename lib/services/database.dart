import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService 
{
  final String uid;
  DatabaseService({ this.uid });
  // collection references
  final CollectionReference brewCollections = Firestore.instance.collection('brews');

  Future updateUserData(String sugar, String name, int strength) async
  {
    return await brewCollections.document(uid).setData
    (
      {
        'sugar': sugar,
        'name': name,
        'strength': strength,
      }
    );
  }
  // Brew list snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc)
    {
      return Brew
      (
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 100,
        sugar: doc.data['sugar'] ?? '0',
      );
    }).toList();
  }
  // UserData from snapshop
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserData
    (
      uid: uid,
      name: snapshot.data['name'],
      sugar: snapshot.data['sugar'],
      strength: snapshot.data['strength'],
    );
  }

  
  // Get brew collection
  Stream<List<Brew>> get brews
  {
    return brewCollections.snapshots().map(_brewListFromSnapshot);
  }

  // Get user data strem
  Stream<UserData> get userData
  {
    return brewCollections.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}