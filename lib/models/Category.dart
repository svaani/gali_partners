import 'package:gali_partners/others/data/firebase_data.dart';

class Category {

    Category(){
          dataRef = FirebaseData("Category");
    }

    FirebaseData dataRef;
    Future<dynamic> getAllByParner(pId) async{
      return await dataRef.getBy("PId",pId);
    }

    Future<bool> createCategory(category) async{
      return await dataRef.add(category);
    }


    Future<bool> updateCategory(category) async{
      return await dataRef.update("CId",category);
    }

    

}