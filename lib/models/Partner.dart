import '../others/data/firebase_data.dart';

class Partner {
  Partner() {
    dataRef = FirebaseData("Partner");
  }

  FirebaseData dataRef;

  Future<bool> doesExist(code) async {
    return await dataRef.doesExist("LoginCode", code);
  }

  Future<String> getPid(code) async {
    var partner = await dataRef.getBy("LoginCode", code);
    return partner[0]["PId"];
  }

  Future<dynamic> getAllByParner(pId) async {
    return await dataRef.getBy("PId", pId);
  }
}
