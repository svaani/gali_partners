import 'package:flutter/material.dart';
import 'package:gali_partners/others/data/local_data.dart';
import 'package:gali_partners/screens/product/product.dart';
import 'package:gali_partners/screens/product/product_api.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductListState();
  }
}

class ProductListState extends State<ProductList> {
  ProductApi _api = ProductApi();
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text("All Products"),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: FutureBuilder(
            future: _api.getProductList(LocalData().getPId()),
            builder: (BuildContext context, AsyncSnapshot itemsnapshot) {
              if (itemsnapshot.connectionState == ConnectionState.done &&
                  itemsnapshot.hasData) {
                if (itemsnapshot.hasError) {
                  return Text('Error: ${itemsnapshot.error}');
                } else {
                  return Column(
                      children: itemsnapshot.data
                          .map<Widget>((product) => Card(
                                child: ListTile(
                                  title: Text(product["Name"]),
                                  leading: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.network(product["Image"]),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => (Product(name:product["Name"],
                                        image:product["Image"],
                                        discount: product["Discount"],
                                        cId: product["CId"],
                                        id: product["PrId"],
                                        price: product["Price"],
                                        viewAtHome: product["ViewAtHome"],
                                        )),
                                      ),
                                    );
                                  },
                                ),
                              ))
                          .toList());
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (Product())),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add)),
    );
  }
}
