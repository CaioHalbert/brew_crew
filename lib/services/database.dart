import 'package:brew_crew/models/brew.dart';
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
        'sugars': sugar,
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
        strength: doc.data['strength'] ?? 0,
        sugar: doc.data['sugar'] ?? '0',
      );
    }).toList();
  }

  
  // Get brew collection
  Stream<List<Brew>> get brews
  {
    return brewCollections.snapshots().map(_brewListFromSnapshot);
  }
}