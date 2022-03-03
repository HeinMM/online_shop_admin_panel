// ignore_for_file: unnecessary_const

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_two_one_admin/injection/Auth/api_staff.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';
import 'package:one_two_one_admin/models/post_data.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}
  Stream<List<PostData>>? posts;
class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    
    var apiKey = Provider.of<LoginStatus>(context).getApiToken();
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Something"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 0.8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        width: 0.8, color: Theme.of(context).primaryColor),
                  ),
                  hintText: 'Search Food or Restaurants',
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  posts =
                    ApiStaff(Dio()).getSearchPost("Bearer $apiKey", "${searchController.text}").asBroadcastStream();
                    
                });
                
              },
              child: const Text('Search'),
            ),
            StreamBuilder<List<PostData>>(
              stream: posts,

              //  ApiStaff(Dio()).getAllPost("Bearer $apiKey"),
              builder: (context, AsyncSnapshot<List<PostData>> snapshots) {
                if (!snapshots.hasData || snapshots.data == null) {
                  return const Center(
                    child: Text('No Data',style: TextStyle(color: Colors.grey,fontSize: 26),),
                  );
                } else if (snapshots.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const Center(
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                        valueColor:  const AlwaysStoppedAnimation(Colors.deepPurple),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshots.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/rabbit.jpg',
                                height: 100,
                                width: 100,
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${snapshots.data![index].title}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${snapshots.data![index].price} MMK",
                                      style: const TextStyle(
                                          color: Colors.pink,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {},
                                  icon:
                                      const Icon(Icons.edit, color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      //),
    );
  }
}
