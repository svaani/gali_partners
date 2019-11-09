import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseData {
  String _collectionRef;
  Firestore _db = Firestore.instance;

  FirebaseData(collectionRef) {
    _collectionRef = collectionRef;
    
    // db.collection("Partner").add({"name":"GeethaGamya"});
  }

  Future<bool> add(content) async {
    var val = await _db.collection(_collectionRef).add(content);
    return val!=null;
  }
  Future<bool> update(ref,content) async {
     QuerySnapshot listOfAll = await _db.collection(_collectionRef).getDocuments();
     var updated = false;
     await listOfAll.documents.forEach((entry) {
      if(entry.data[ref].toString() == content["id"].toString()){
        content[ref] = content["id"];
        entry.reference.setData(content);
        updated = true;
      }
    });
    return updated;
     
  }

  Future<dynamic> get() async {
    QuerySnapshot xyz = await _db.collection(_collectionRef).getDocuments();
    List allData = [];
    xyz.documents.forEach((entry) {
      allData.add(entry.data);
    });
    return allData;
  }
  
  Future<dynamic> getBy(key,val) async {
    QuerySnapshot xyz = await _db.collection(_collectionRef).getDocuments();
    List allData = [];
    xyz.documents.forEach((entry) {
      if(entry.data[key] == val)
      allData.add(entry.data);
    });
    return allData;
  }

  Future<bool> doesExist(String key, String val) async {
    QuerySnapshot xyz = await _db.collection(_collectionRef).getDocuments();
    return -1 !=
        xyz.documents.indexWhere((entry) {
          return val == entry.data[key];
        });
  }
}
