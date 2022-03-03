import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_two_one_admin/injection/Auth/api_staff.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';
import 'package:one_two_one_admin/models/api_message.dart';
import 'package:one_two_one_admin/models/post_data.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final _categoryList = ['Select Category', 'natureRebuplic', 'innisfree'];
  var _categoryValue = 'Select Category';
  final _formKey = GlobalKey<FormState>();
  File? image;
  final _picker = ImagePicker();
   bool showSpinner = false;

  Future getImage() async {
    final PickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (PickedFile != null) {
      image = File(PickedFile.path);
      setState(() {});
    } else {
      print('no image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController qtyController = TextEditingController();
    TextEditingController desController = TextEditingController();

    var categoryIndex = Provider.of<LoginStatus>(context);

    return Container(
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
                      _categoryValue = newValue as String;
                    });
                  }),
              Container(
                  child: image == null
                      ? Center(
                          child: Text('Pick Image'),
                        )
                      : Container(
                          child: Center(
                            child: Image.file(
                              File(image!.path).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
              ElevatedButton.icon(
                onPressed: () {
                  getImage();
                },
                icon: Icon(Icons.image),
                label: Text('pick'),
              ),
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
                      labelText: 'Qty',
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                  validator: (value) {
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
                    String category = "${categoryIndex.getCategoryIndex()}";

                    PostData postData = PostData(
                        id: 0,
                        title: titleController.text,
                        category_id: category,
                        price: priceController.text,
                        dec: desController.text,
                        qty: qtyController.text);

                    ApiMessage responMessage = await ApiStaff(Dio())
                        .uploadPost("Bearer $apiToken", postData);
                    if (responMessage.status) {
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(responMessage.message),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      titleController.clear();
                      priceController.clear();
                      qtyController.clear();
                      desController.clear();
                    }
                  }
                },
                child: const Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
