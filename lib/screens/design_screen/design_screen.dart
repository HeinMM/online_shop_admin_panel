// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class DesignScreen extends StatefulWidget {
  const DesignScreen({Key? key}) : super(key: key);

  @override
  _DesignScreenState createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
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
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Banner',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    width: 70,
                   
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
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Slider',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    width: 70,
                   
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
              height:100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Our Recommend',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                
                  Container(
                    width: 70,
                   
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
