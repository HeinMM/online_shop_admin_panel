import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_two_one_admin/injection/Auth/api_staff.dart';
import 'package:one_two_one_admin/injection/Auth/login_status.dart';
import 'package:one_two_one_admin/models/api_message.dart';
import 'package:one_two_one_admin/models/staff_for_login.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var islogin = Provider.of<LoginStatus>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    "LogIn",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email_outlined),
                              labelText: 'Email',
                            // counterText: 'a@gmail.com',
                              //hintText: 'a@gmail.com',
                              hoverColor: Colors.blueGrey,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email';
                              }
                               return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.lock_outline,
                              ),
                              labelText: 'Password',
                             
                              hoverColor: Colors.blueGrey,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              }
                               return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          islogin.getIsFailLogin()
                              ? const Text(
                                  '.Email or Password is wrong,Try it Again',
                                  style: TextStyle(color: Colors.pink),
                                )
                              : const Text(''),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            color: Colors.blueGrey,
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () async {
                                StaffForLogin staffData = StaffForLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                                ApiMessage message =
                                    await ApiStaff(Dio()).login(staffData);
                                if (_formKey.currentState!.validate()) {
                                  if (message.status && message.isAdmin) {
                                    Provider.of<LoginStatus>(context,
                                            listen: false)
                                        .setIsLogin(message.status);
                                     islogin.setCurrentUser(emailController.text);
                                         
                                      Provider.of<LoginStatus>(context,listen: false).setApiToken(message.token);
                                   
                                    Provider.of<LoginStatus>(context,listen: false).setIsFailLogin(false);
                                    
                                  } else {
                                    islogin.setIsLogin(false);
                                    islogin.setIsFailLogin(true);
                                  }
                                }else{
                                  return null;
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
