import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Conditions"),
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 150,
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Waiting Order',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text(
                      '1',
                      style: TextStyle(color: Colors.pink, fontSize: 25),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        onPressed: () {},
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
              height: 150,
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Confirmed Order',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
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
              height: 150,
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Rejected Order',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
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
