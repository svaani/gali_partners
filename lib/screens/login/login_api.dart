import '../../models/Partner.dart';

class LoginApi {
  Future<bool> login(code) async {
    return await Partner().doesExist(code);
  }

  Future<String> getPartnerId(code) async{
    return await Partner().getPid(code);
  }
}
