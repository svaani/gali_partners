import 'package:gali_partners/models/Partner.dart';

class ProfileApi {
  
  Future<List> getInfo(pId) async {
    return await Partner().getAllByParner(pId);
  }

}