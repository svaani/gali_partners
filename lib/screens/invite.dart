import 'package:flutter/material.dart';
import 'package:gali_partners/others/constants/general_const.dart';

class Invite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Users"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: "Enter Phone number1"),),
            
            TextField(decoration: InputDecoration(labelText: "Enter Phone number2"),),
            
            TextField(decoration: InputDecoration(labelText: "Enter Phone number3"),),
            
            TextField(decoration: InputDecoration(labelText: "Enter Phone number4"),),
            RaisedButton(child: Text("Send Invite"),onPressed: (){},color: GeneralConst().BUTTON_COLOR,)
          ],
        ),
      ),
    );
  }
}
