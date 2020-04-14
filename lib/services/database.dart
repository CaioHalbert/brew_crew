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
        'strangth': strength,
      }
    );
  }
}