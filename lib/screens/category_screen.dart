import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_two_one_admin/injection/Auth/api_staff.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';
import 'package:one_two_one_admin/screens/catergory_detail.dart';
import 'package:one_two_one_admin/screens/edit_screen.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var apiKey = Provider.of<LoginStatus>(context);
    var categories = [
      'naturerepublic',
      'innisfree',
      'Laneige',
      'mamonde',
      'manyo',
      'I\'m Form',
      'Eduehouse',
      'Tonymony',
      'HelloBubble',
      'The Sum',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: categories.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              categories[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 70,
                              margin: const EdgeInsets.only(right: 20),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryDetail(
                                        name: categories[index],
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
