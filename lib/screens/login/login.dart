import 'package:flutter/material.dart';
import 'package:gali_partners/others/constants/general_const.dart';
import 'package:gali_partners/others/data/local_data.dart';
import 'package:gali_partners/screens/home/home.dart';
import '../../screens/login/login_api.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  GlobalKey scaffoldKey = GlobalKey();
  TextEditingController _loginCode = TextEditingController();

  LoginApi _api = LoginApi();

  _submit(context) async {
    if (await _api.login(_loginCode.text)) {
      LocalData().setPId(await _api.getPartnerId(_loginCode.text));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => (Home())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                cursorWidth: 8,
                obscureText: true,
                controller: _loginCode,
                decoration: InputDecoration(
                  labelText: "Enter Login Code :",
                ),
              ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  _submit(context);
                },
                color: GeneralConst().BUTTON_COLOR,
              )
            ],
          ),
        ),
      ),
    );
  }
}
