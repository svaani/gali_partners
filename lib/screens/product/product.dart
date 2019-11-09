import 'package:flutter/material.dart';
import 'package:gali_partners/others/constants/general_const.dart';
import 'package:gali_partners/others/data/local_data.dart';
import 'package:gali_partners/screens/product/product_api.dart';

class Product extends StatefulWidget {
  var name, image, discount, id, viewAtHome, price, cId;
  Product(
      {this.name,
      this.image,
      this.discount,
      this.id,
      this.viewAtHome,
      this.price,
      this.cId});
  @override
  State<StatefulWidget> createState() {
    return ProductState(
        name: this.name,
        image: this.image,
        discount: this.discount,
        id: this.id,
        viewAtHome: this.viewAtHome,
        price: this.price,
        cId: this.cId);
  }
}

class ProductState extends State<Product> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  ProductApi _api = ProductApi();
  TextEditingController _name = TextEditingController();
  TextEditingController _image = TextEditingController();
  TextEditingController _discount = TextEditingController();
  TextEditingController _price = TextEditingController();
  bool _viewAtHome = false;
  String _category = null;
  var _prid = null;

  ProductState({name, image, discount, id, viewAtHome, price, cId}) {
    _name.text = name ?? "";
    _image.text = image ?? "";
    _discount.text = discount?? "";
    _viewAtHome = viewAtHome ?? false;
  //  _category = null;
    _category = cId==null ? null : cId.toString();
    _price.text = price??"";
    _prid = id==null ? null : id.toString();
  }

  _create(context) async {
    var result = await _api.createProduct(
        name: _name.text,
        image: _image.text,
        discount: _discount.text,
        id: DateTime.now().millisecondsSinceEpoch,
        viewAtHome: _viewAtHome,
        price: _price.text,
        cId: _category,
        pId: LocalData().getPId());
    if (result == true) {
      scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text("Product Created"),
        backgroundColor: GeneralConst().SUCCESS_COLOR,
        duration: GeneralConst().MESSAGE_DURATION,
      ));
      Future.delayed(GeneralConst().MESSAGE_DURATION, () {
        Navigator.pop(context);
      });
    }
  }

  _updateRecord(context) async {
    var result = await _api.updateProduct(
        name: _name.text,
        image: _image.text,
        discount: _discount.text,
        viewAtHome: _viewAtHome,
        price: _price.text,
        cId: _category,
        id: _prid,
        pId: LocalData().getPId());
    if (result == true) {
      scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text("Product Updated"),
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
        title: Text("Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: "Product Name"),
              cursorWidth: 8,
            ),
            FutureBuilder(
                future: _api.getCategoryList(LocalData().getPId()),
                builder: (BuildContext context, AsyncSnapshot itemsnapshot) {
                  if (itemsnapshot.connectionState == ConnectionState.done &&
                      itemsnapshot.hasData) {
                    List list = itemsnapshot.data;
                    return DropdownButton<String>(
                      value: _category,
                      items: list
                          .map((item) => DropdownMenuItem<String>(
                              value: item["CId"].toString(),
                              child: Text(item["Name"])))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _category = val.toString();
                        });
                      },
                      isExpanded: true,
                      hint: Text('Assign Category :'),
                    );
                  }
                  else {
                    return Center(child:CircularProgressIndicator());
                  }
                }),
            TextField(
              controller: _image,
              decoration: InputDecoration(labelText: "Image URL"),
              cursorWidth: 8,
            ),
            TextField(
              controller: _price,
              decoration: InputDecoration(labelText: "Price"),
              cursorWidth: 8,
            ),
            TextField(
              controller: _discount,
              decoration: InputDecoration(labelText: "Discount"),
              cursorWidth: 8,
            ),
            Row(
              children: <Widget>[
                Text("View At Home"),
                Checkbox(
                  value: _viewAtHome,
                  onChanged: (val) {
                    setState(() {
                      _viewAtHome = val;
                    });
                  },
                )
              ],
            ),
            Center(
              child: RaisedButton(
                child: _prid == null ? Text("Create") : Text("Update"),
                onPressed: () {
                  _prid == null ? _create(context) : _updateRecord(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
