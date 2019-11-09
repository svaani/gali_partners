import 'package:gali_partners/others/data/firebase_data.dart';

class Product {

    Product(){
          dataRef = FirebaseData("Product");
    }

    FirebaseData dataRef;
    Future<dynamic> getAllByParner(pId) async{
      return await dataRef.getBy("PId",pId);
    }

    Future<bool> createProduct(product) async{
      return await dataRef.add(product);
    }


    Future<bool> updateProduct(product) async{
      return await dataRef.update("PrId",product);
    }

    

}