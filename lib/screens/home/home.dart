import 'package:flutter/material.dart';
import 'package:gali_partners/others/data/local_data.dart';
import 'package:gali_partners/screens/category/category_list.dart';
import 'package:gali_partners/screens/invite.dart';
import 'package:gali_partners/screens/login/login.dart';
import 'package:gali_partners/screens/product/product_list.dart';
import 'package:gali_partners/screens/profile/view_profile.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  GlobalKey scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Welcome !"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: ListTile(
                title: Text("Category List"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => (CategoryList())),
                  );
                }),
          ),
          Card(
            child: ListTile(
                title: Text("All Products"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (ProductList()),
                    ),
                  );
                }),
          ),
          Card(
            child: ListTile(
                title: Text("View Profile"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (ViewProfile())),
                  );
                }),
          ),
          Card(
            child: ListTile(
                title: Text("Invite Customer"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (Invite())),
                  );
                }),
          ),
          Card(
            child: ListTile(
                title: Text("Logout"),
                onTap: () {
                  LocalData().setPId(null);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => (Login())),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
