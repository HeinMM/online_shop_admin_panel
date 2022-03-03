import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';

import 'package:one_two_one_admin/models/sale_data.dart';
import 'package:one_two_one_admin/screens/sale_screen/sale_screen.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import 'dart:convert';

import 'package:provider/provider.dart';

class AddSalePost extends StatefulWidget {
  const AddSalePost({Key? key}) : super(key: key);

  @override
  State<AddSalePost> createState() => _AddSalePostState();
}

class _AddSalePostState extends State<AddSalePost> {
  final _formKey = GlobalKey<FormState>();

  // List<File> fileImage = <File>[];
  List<Asset>? image = <Asset>[];
  List<MultipartFile> multipartImageList = [];
  String _error = 'No Error Detected';

  bool showSpinner = false;
  bool responStatus = false;
  String responMessage = "";

  var progress;

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

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
    // ignore: avoid_function_literals_in_foreach_calls
    // resultList.forEach(/////////////////////////////////////////////////MY NOTE changing Asset file to File
    //   (asset) async {
    //     try {
    //       final byteData = await asset.getByteData();

    //       final tempFile =
    //           File("${(await getTemporaryDirectory()).path}/${asset.name}");

    //       final file = await tempFile.writeAsBytes(
    //         byteData.buffer
    //             .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    //       );

    //       fileImage.add(file);
    //     } catch (e) {
    //       print(e);
    //     }
    //   },
    // );
  }

  upload(
      List<Asset>? assetImage, SaleData saleData, BuildContext context) async {
    for (Asset asset in assetImage!) {
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(
        imageData,
        filename: asset.name!.split('/').last,
        contentType: MediaType('image', "jpg"),
      );
      multipartImageList.add(multipartFile);
    }
    var data = FormData.fromMap({
      "images[]": multipartImageList,
      "title": saleData.title,
      "normal_price": saleData.normal_price,
      "sale_price": saleData.sale_price,
      "dec": saleData.dec,
      "qty": saleData.qty,
      "waiting_time": saleData.waiting_time
    });
    Dio dio = Dio();
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
        max: 100,
        msg: 'Image Uploading...',
        progressType: ProgressType.valuable,
        progressBgColor: Colors.transparent);
    Response<String> response = await dio
        .post("http://192.168.219.100:80/api/sale", data: data,
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
       Navigator.pop(context);
       
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(responMessage),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

     
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController normalPriceController = TextEditingController();
    TextEditingController salePriceController = TextEditingController();
    TextEditingController qtyController = TextEditingController();
    TextEditingController desController = TextEditingController();
    TextEditingController waitingController = TextEditingController();

    //var categoryIndex = Provider.of<LoginStatus>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Sale'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                    controller: normalPriceController,
                    decoration: const InputDecoration(
                        hintText: "Normal Price",
                        labelText: 'Normal Price',
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Normal Price must not empty";
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: salePriceController,
                    decoration: const InputDecoration(
                        hintText: "Sale Price",
                        labelText: 'Sale Price',
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Normal Price must not empty";
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
                    controller: waitingController,
                    decoration: const InputDecoration(
                        hintText: "Waiting Time",
                        labelText: 'Waiting Time',
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Waiting Time must not empty";
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

                      SaleData saleData = SaleData(
                        id: 0,
                        title: titleController.text,
                        normal_price: normalPriceController.text,
                        sale_price: salePriceController.text,
                        dec: desController.text,
                        qty: qtyController.text,
                        waiting_time: waitingController.text,
                      );
                      upload(image, saleData, context);
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
