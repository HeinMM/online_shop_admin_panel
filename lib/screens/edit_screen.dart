import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_two_one_admin/injection/Auth/api_staff.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';
import 'package:one_two_one_admin/models/api_message.dart';
import 'package:one_two_one_admin/models/post_data.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  int? id;
  EditScreen({Key? key, @required this.id}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
    PostData? post;
  String? category;
  final _categoryList = ['Select Category', 'natureRebuplic', 'innisfree'];
  String? _categoryValue ;
  final _formKey = GlobalKey<FormState>();
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? qtyController;
  TextEditingController? desController;

  

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    String api = Provider.of<LoginStatus>(context, listen: false).getApiToken();
    post = await ApiStaff(Dio()).getPostById("Bearer $api", widget.id!);

    setState(() {
      try {
        titleController = TextEditingController(text: post!.title);
        priceController = TextEditingController(text: post!.price);
        qtyController = TextEditingController(text: post!.qty);
        desController = TextEditingController(text: post!.dec);
         category = post!.category_id;
         
         _categoryValue = _categoryList[int.parse(category!)];
         print(_categoryValue);
      } catch (e) {
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              valueColor: new AlwaysStoppedAnimation(Colors.deepPurple),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var categoryIndex = Provider.of<LoginStatus>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButton(
                    value: _categoryValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: _categoryList.map((String category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (var newValue) {
                      categoryIndex.setCategoryindex(
                          _categoryList.indexOf(newValue as String));
                      setState(() {
                        print(newValue);
                        _categoryValue = newValue;
                        print(_categoryValue);
                      });
                    }),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        hintText: "Product title",
                        labelText: 'title',
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      var values = value.runtimeType;
                      if (value == null || value.isEmpty || values != String) {
                        return "Product Name must not empty";
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(
                        hintText: "Price",
                        labelText: 'Price',
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Price must not empty";
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: qtyController,
                    decoration: const InputDecoration(
                        hintText: "Qty",
                        labelText: 'Product Name',
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      var values = value.runtimeType;
                      if (value == null || value.isEmpty) {
                        return "Qty must not empty";
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: desController,
                    decoration: const InputDecoration(
                      hintText: "Enter Discerption",
                      labelText: 'Discerption',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      //border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    maxLines: 20,
                    minLines: 15,
                    validator: (value) {
                      var values = value.runtimeType;
                      if (value == null || value.isEmpty || values != String) {
                        return "Discerption must not empty";
                      }
                    },
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String apiToken =
                          Provider.of<LoginStatus>(context, listen: false)
                              .getApiToken();
                        
                       category = "${categoryIndex.getCategoryIndex()}";
                      print(category);
                      PostData postData = PostData(
                        id: widget.id,
                        title: titleController!.text,
                        category_id: category,
                        price: priceController!.text,
                        dec: desController!.text,
                        qty: (qtyController!.text),
                      );

                      ApiMessage responMessage = await ApiStaff(Dio())
                          .editPost("Bearer $apiToken", postData, widget.id!);
                      if (responMessage.status) {
                        final snackBar = SnackBar(
                          content: Text(responMessage.message),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        titleController!.clear();
                        priceController!.clear();
                        qtyController!.clear();
                        desController!.clear();
                      }
                    }
                  },
                  child: const Text('Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
