import 'package:flutter/material.dart';
import 'package:one_two_one_admin/widgets/post_widget.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {
         var result =  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const PostWidget();
                    },
                    fullscreenDialog: true,
                  ),
                );
                if (result=='back') {
                  print('hit');
                  // Provider.of<LoginStatus>(context).setCategoryName("Select Category");
                }
        }, child: const Text('Let Post!')),
      ),
    );
  }
}
