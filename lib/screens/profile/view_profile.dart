import 'package:flutter/material.dart';
import 'package:gali_partners/others/data/local_data.dart';
import 'package:gali_partners/screens/profile/profile_api.dart';

class ViewProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ViewProfileState();
  }
}

class ViewProfileState extends State<ViewProfile> {
  ProfileApi _api = ProfileApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile Information"),
        ),
        body: FutureBuilder(
            future: _api.getInfo(LocalData().getPId()),
            builder: (BuildContext context, AsyncSnapshot itemsnapshot) {
              if (itemsnapshot.connectionState == ConnectionState.done &&
                  itemsnapshot.hasData) {
                if (itemsnapshot.hasError) {
                  return Text('Error: ${itemsnapshot.error}');
                } else {
                  var infoData = itemsnapshot.data[0];
                  return Column(
                    children: <Widget>[
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: infoData["Name"],
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                      Card(
                        child: Text(infoData["Address"]),
                      ),
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: infoData["Phone"],
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                      
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: "View at Home Price :"+infoData["ViewAtHomePrice"] + "Rs",
                            labelStyle: TextStyle(color: Colors.black)),
                      )
                    ],
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
