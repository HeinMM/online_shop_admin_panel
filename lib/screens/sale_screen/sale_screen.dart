import 'package:flutter/material.dart';
import 'package:one_two_one_admin/screens/sale_screen/add_sale_post.dart';
import 'package:one_two_one_admin/screens/sale_screen/current_sale_post.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Add Sale Post',
                      style: TextStyle(
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
                              builder: (context) => const AddSalePost(),
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
          ),
          Card(
            elevation: 5,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Sale Posts',
                      style: TextStyle(
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
                              builder: (context) => const CurrentSalePost(),
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
          ),
        ],
      ),
    );
  }
}
