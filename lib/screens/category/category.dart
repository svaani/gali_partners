import 'package:flutter/material.dart';
import 'package:gali_partners/others/constants/general_const.dart';
import 'package:gali_partners/others/data/local_data.dart';
import 'package:gali_partners/screens/category/category_api.dart';

class Category extends StatefulWidget {
  var _name, _image, _discount, _cid;

  Category({name, image, discount, cid}) {
    _name = name;
    _image = image;
    _discount = discount;
    _cid = cid;
  }
  @override
  State<StatefulWidget> createState() {
    return CategoryState(
        name: _name, image: _image, discount: _discount, cid: _cid);
  }
}

class CategoryState extends State<Category> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _image = TextEditingController();
  TextEditingController _discount = TextEditingController();
  var _cid = null;

  CategoryState({name, image, discount, cid}) {
    _name.text = name;
    _image.text = image;
    _discount.text = discount.toString();
    _cid = cid.toString();
  }

  CategoryApi _api = CategoryApi();

  _create(context) async {
    var result = await _api.createCategory(
        name: _name.text,
        image: _image.text,
        discount: _discount.text,
        id: DateTime.now().millisecondsSinceEpoch,
        pId: LocalData().getPId());
    if (result == true) {
      scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text("Category Created"),
        backgroundColor: GeneralConst().SUCCESS_COLOR,
        duration: GeneralConst().MESSAGE_DURATION,
      ));
      Future.delayed(GeneralConst().MESSAGE_DURATION, () {
        Navigator.pop(context);
      });
    }
  }

  _updateRecord(context) async {
    var result = await _api.updateCategory(
        name: _name.text,
        image: _image.text,
        discount: _discount.text,
        id: _cid,
        pId: LocalData().getPId());
    if (result == true) {
      scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text("Category Updated"),
        backgroundColor: GeneralConst().SUCCESS_COLOR,
        duration: GeneralConst().MESSAGE_DURATION,
      ));
      Future.delayed(GeneralConst().MESSAGE_DURATION, () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          title: Text("Category"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _name,
                decoration: InputDecoration(labelText: "Category Name"),
                cursorWidth: 8,
              ),
              TextField(
                controller: _image,
                decoration: InputDecoration(labelText: "Image URL"),
                cursorWidth: 8,
              ),
              TextField(
                controller: _discount,
                decoration: InputDecoration(labelText: "Categorywise Discount"),
                cursorWidth: 8,
              ),
              Center(
                child: RaisedButton(
                  child: _cid == null ? Text("Create") : Text("Update"),
                  onPressed: () {
                    _cid == null ? _create(context) : _updateRecord(context);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
