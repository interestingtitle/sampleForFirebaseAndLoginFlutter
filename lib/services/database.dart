import 'package:brew_crew/models/apt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference aptCollection = FirebaseFirestore.instance.collection("apts");

  Future updateUserData(String champ, String name, int level) async{
    return await aptCollection.doc(uid).set({
      'champ': champ,
      'name': name,
      'level': level,
    });
  }

  //apt list from snapshot
  List<Apt> _aptListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Apt(
        name: doc.data()['name'] ?? '',
        champ: doc.data()['champ'] ?? '',
        level: doc.data()['level'] ?? 0,
      );
    }).toList();
  }



  //get apts stream
  Stream<List<Apt>> get apts{
    return aptCollection.snapshots()
      .map(_aptListFromSnapshot);
  }

}