import 'package:gali_partners/models/Category.dart';

class CategoryApi {
  
  Future<List> getCategoryList(pId) async {
    return await Category().getAllByParner(pId);
  }

  Future<bool> createCategory({name, image, discount, pId, id}) async {
    return await Category().createCategory({
      "Name": name,
      "Image": image,
      "Discount": discount,
      "PId": pId,
      "CId": id
    });
  }

  Future<bool> updateCategory({name, image, discount, pId, id}) async {
    return await Category().updateCategory({
      "Name": name,
      "Image": image,
      "Discount": discount,
      "PId": pId,
      "id": id
    });
  }
}
