import 'package:flutter/material.dart';
import 'package:gali_partners/others/data/local_data.dart';
import 'package:gali_partners/screens/category/category.dart';
import 'package:gali_partners/screens/category/category_api.dart';

class CategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryListState();
  }
}

class CategoryListState extends State<CategoryList> {
  CategoryApi _api = CategoryApi();

  GlobalKey scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text("Category List"),
      ),
      body: FutureBuilder(
          future: _api.getCategoryList(LocalData().getPId()),
          builder: (BuildContext context, AsyncSnapshot itemsnapshot) {
            if (itemsnapshot.connectionState == ConnectionState.done &&
                itemsnapshot.hasData) {
              if (itemsnapshot.hasError) {
                return Text('Error: ${itemsnapshot.error}');
              } else {
                return Column(
                    children: itemsnapshot.data
                        .map<Widget>((category) => Card(
                              child: ListTile(
                                title: Text(category["Name"]),
                                leading: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.network(category["Image"]),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => (Category(
                                          name: category["Name"],
                                          image: category["Image"],
                                          discount: category["Discount"],
                                          cid: category["CId"])),
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (Category())),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add)),
    );
  }
}
