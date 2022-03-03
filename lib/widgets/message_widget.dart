import 'package:flutter/material.dart';

class MessageWidge extends StatefulWidget {
  const MessageWidge({Key? key}) : super(key: key);

  @override
  _MessageWidgeState createState() => _MessageWidgeState();
}

class _MessageWidgeState extends State<MessageWidge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('im message'),
      ),
    );
  }
}
