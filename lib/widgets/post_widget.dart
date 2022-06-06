import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';
import 'package:one_two_one_admin/models/post_data.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final _categoryList = ['Select Category', 'natureRebuplic', 'innisfree'];
  var _categoryValue = 'Select Category';
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  bool showSpinner = false;

  List<Asset>? image = <Asset>[];
  List<MultipartFile> multipartImageList = [];
  String _error = 'No Error Detected';

  String responMessage = "";
  bool responStatus = false;

 

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    if (resultList != null || multipartImageList!= null||image != null) {
      resultList.clear();
      multipartImageList.clear();
      image!.clear();
    }

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: image!,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;
    setState(() {
      image = resultList;
      _error = error;
    });
  }

 Future<bool> upload(
      List<Asset>? assetImage, PostData postData, BuildContext context) async {
    for (Asset asset in assetImage!) {
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(
        imageData,
        filename: asset.name!.split('/').last,
        contentType: MediaType('image', "jpeg"),
      );
      
      multipartImageList.add(multipartFile);
    }

     print("${ Provider.of<LoginStatus>(context,listen: false).getCategoryIndex()}");
     print("${ Provider.of<LoginStatus>(context,listen: false).getCategoryName()}");
    
      print(multipartImageList);
    
    var data = FormData.fromMap({
      "images[]": multipartImageList,
      "title": postData.title,
      "price": postData.price,
      "category_id": postData.category_id,
      "dec": postData.dec,
      "qty": postData.qty,
    });
    Dio dio = Dio();
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
        max: 100,
        msg: 'Image Uploading...',
        progressType: ProgressType.valuable,
        progressBgColor: Colors.transparent);
    Response<String> response = await dio
        .post("http://192.168.219.103:80/api/post", data: data,
            onSendProgress: (int sent, int total) {
      int progress = (((sent / total) * 100).toInt());

      pd.update(value: progress);
      
      
    });

    Map<String, dynamic> responseBody = json.decode(response.data!);
    setState(() {
      responStatus = responseBody['status'];
      responMessage = responseBody['message'];
    });

    if (responStatus) {
      Navigator.pop(context,'back');

      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(responMessage),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );
      image!.clear();

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return true;
  }
  

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController qtyController = TextEditingController();
    TextEditingController desController = TextEditingController();

    var categoryIndex = Provider.of<LoginStatus>(context);
    var categoryName = Provider.of<LoginStatus>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('upload'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButton(
                    value: categoryName.getCategoryName(),
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
                          categoryName.setCategoryName(newValue);
                    }),
                image!.isEmpty || image == null
                    ? const Text('select Images')
                    : Container(
                        width: double.infinity,
                        height: 200,
                        child: buildGridView(context),
                        decoration: const BoxDecoration(color: Colors.grey),
                      ),
                Row(
                  mainAxisAlignment: image!.isEmpty
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        await loadAssets();
                      },
                      icon: const Icon(Icons.image),
                      label: const Text('select'),
                    ),
                    image!.isEmpty
                        ? const SizedBox()
                        : ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                image!.clear();
                              });
                            },
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('delete all'),
                          ),
                  ],
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
                      PostData postData = PostData(
                          id: 0,
                          title: titleController.text,
                          // category_id: "${categoryIndex.getCategoryIndex()}",
                          category_id:"1",
                          price: priceController.text,
                          dec: desController.text,
                          qty: qtyController.text);

                    var result =await  upload(image, postData, context);
                      if (result) {
                        image!.clear();
                        multipartImageList.clear();
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

  Widget buildGridView(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(image!.length, (index) {
        Asset asset = image![index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }
}
