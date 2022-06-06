// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_two_one_admin/injection/Auth/api_staff.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';
import 'package:one_two_one_admin/injection/design/design_injection.dart';
import 'package:one_two_one_admin/models/api_message.dart';
import 'package:one_two_one_admin/models/current_user.dart';
import 'package:one_two_one_admin/screens/category_screen.dart';
import 'package:one_two_one_admin/screens/design_screen/design_screen.dart';
import 'package:one_two_one_admin/screens/orders_screen.dart';
import 'package:one_two_one_admin/screens/post_screen/post.dart';
import 'package:one_two_one_admin/screens/posts_screen.dart';
import 'package:one_two_one_admin/screens/sale_screen/sale_screen.dart';
import 'package:one_two_one_admin/screens/search_screen.dart';
import 'package:one_two_one_admin/widgets/message_widget.dart';
import 'package:one_two_one_admin/widgets/post_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var currentIndex = Provider.of<DesignInjection>(context);
    var isLogOut = Provider.of<LoginStatus>(context);
    var screenindex = Provider.of<LoginStatus>(context);
    //
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('RealSmartAdmin'),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            ListTile(
              leading: const Text("             "),
              trailing: const Icon(
                Icons.search,
                size: 25,
                color: Colors.white,
              ),
              title: const Text(
                'Search',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SearchScreen();
                    },
                  ),
                );
              },
            ),
             ListTile(
              leading: const Text("             "),
              trailing: const Icon(
                Icons.category_outlined,
                size: 25,
                color: Colors.white,
              ),
              title: const Text(
                'Categories',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CategoryScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Text("             "),
              trailing: const Icon(
                Icons.celebration,
                size: 25,
                color: Colors.white,
              ),
              title: const Text(
                'Sale',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SaleScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Text("             "),
              trailing: const Icon(
                Icons.history,
                size: 25,
                color: Colors.white,
              ),
              title: const Text(
                'History',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const PostsScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Text("             "),
              trailing: const Icon(
                Icons.list_alt,
                size: 25,
                color: Colors.white,
              ),
              title: const Text(
                'Orders',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const OrderScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Text("             "),
              trailing: const Icon(
                Icons.celebration,
                size: 25,
                color: Colors.white,
              ),
              title: const Text(
                'Design',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DesignScreen();
                    },
                    
                  ),
                );
              },
            ),
            ListTile(
              leading: const Text("             "),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              trailing: const Icon(
                Icons.logout,
                size: 25,
                color: Colors.white,
              ),
              onTap: () async {
                CurrentUser data = CurrentUser(isLogOut.getCurrentUser());
                ApiMessage message = await ApiStaff(Dio()).logout(data);
                isLogOut.setIsLogin(message.status);
              },
            )
          ],
        ),
      ),
      body: screenindex.getScreenIndex() ? Post() : MessageWidge(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) async {
          currentIndex.setCurrentIndex(index);

          if (index == 0) {
            screenindex.setScreenIndex(true);
          }
          if (index == 1) {
            screenindex.setScreenIndex(false);
          }
          if (index == 2) {}
        },
        currentIndex: currentIndex.getCurrentIndex(),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: 'Post'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined), label: 'Message'),
          // const BottomNavigationBarItem(
          //     icon: Icon(Icons.logout_outlined), label: 'LogOut'),
          // const BottomNavigationBarItem(
          //     icon: Icon(Icons.admin_panel_settings_outlined), label: 'CEO')
        ],
      ),
      // body: PostWidget(),
    );
  }
}
