import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_two_one_admin/injection/Auth/api_staff.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';
import 'package:one_two_one_admin/models/post_data.dart';
import 'package:one_two_one_admin/screens/edit_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryDetail extends StatefulWidget {
  String? name;
  CategoryDetail({Key? key, this.name}) : super(key: key);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    var apiKey = Provider.of<LoginStatus>(context).getApiToken();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name!),
      ),
      body: StreamBuilder<List<PostData>>(
          stream:
              ApiStaff(Dio()).getSearchPostByCategory("Bearer $apiKey", widget.name!),
          builder: (context, AsyncSnapshot<List<PostData>> snapshots) {
            if (!snapshots.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                    valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshots.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: SizedBox(
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditScreen(
                                        id: snapshots.data![index].id,
                                      ),
                                    ),
                                  );
                                },
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
                  });
            }
          }),
    );
  }
}
