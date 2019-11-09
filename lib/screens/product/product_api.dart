import 'package:gali_partners/models/Category.dart';
import 'package:gali_partners/models/Product.dart';

class ProductApi {


  Future<List> getProductList(pId) async {
    return await Product().getAllByParner(pId);
  }

  Future<List> getCategoryList(pId) async {
    return await Category().getAllByParner(pId);
  }

  
  Future<bool> createProduct({name, image, discount, pId, id,viewAtHome,price,cId}) async {
    return await Product().createProduct({
      "Name": name,
      "Image": image,
      "Discount": discount,
      "PId": pId,
      "CId": cId,
      "PrId" : id,
      "ViewAtHome" : viewAtHome,
      "Price" : price
    });
  }

  Future<bool> updateProduct({name, image, discount, pId, id,viewAtHome,price,cId}) async {
    return await Product().updateProduct({
      "Name": name,
      "Image": image,
      "Discount": discount,
      "PId": pId,
      "CId": cId,
      "id" : id,
      "ViewAtHome" : viewAtHome,
      "Price" : price
    });
  }

}