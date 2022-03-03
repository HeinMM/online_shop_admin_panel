import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_two_one_admin/injection/Auth/api_staff.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';
import 'package:one_two_one_admin/models/sale_data.dart';

import 'package:provider/provider.dart';

class CurrentSalePost extends StatefulWidget {
  const CurrentSalePost({Key? key}) : super(key: key);

  @override
  State<CurrentSalePost> createState() => _CurrentSalePostState();
}

class _CurrentSalePostState extends State<CurrentSalePost> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var apiKey = Provider.of<LoginStatus>(context).getApiToken();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Posts'),
      ),
      body: StreamBuilder<List<SaleData>>(
        stream: ApiStaff(Dio()).getAllSalePost("Bearer $apiKey"),
        builder: (context, AsyncSnapshot<List<SaleData>> snapshots) {
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
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: 
                          CachedNetworkImage(
                            imageUrl: "${snapshots.data![index].sale_images![0].file_path}",
                            placeholder: (context, url) => const SizedBox(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                                fit: BoxFit.fill,
                          ),
                        ),
                        
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${snapshots.data![index].title}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '${snapshots.data![index].sale_price} Ks',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${snapshots.data![index].normal_price} Ks',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              )
                            ],
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
    );
  }
}
