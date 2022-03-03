import 'package:flutter/material.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';
import 'package:one_two_one_admin/injection/design/design_injection.dart';
import 'package:one_two_one_admin/screens/home.dart';
import 'package:one_two_one_admin/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginStatus()),
        ChangeNotifierProvider(create: (context) => DesignInjection()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var providerLogin = Provider.of<LoginStatus>(context);
    return MaterialApp(
      
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: providerLogin.getIsLogin() ?const Home() :const LoginScreen()
    );
  }
}
