
import 'package:flutter/cupertino.dart';

class LoginStatus extends ChangeNotifier{
  
  bool _isLogin = false;
   String _apiToken = ' ';
   bool? _isFailLogin = false;
   String _currentUser ="";
   bool _screenIndex = true;
   int _categoryIndex = 0;
   String _categoryName = "Select Category";

/////////////////////////////////////////this is chacking login state by boolien
  bool getIsLogin(){
    return _isLogin;
  }

  void setIsLogin(bool islogin){
    _isLogin = islogin;
    notifyListeners();
  }
/////////////////////////////////////////
  String getApiToken(){
    return _apiToken;
  }

  void setApiToken(String apiToken){
    _apiToken = apiToken;
    notifyListeners();
  }
/////////////////////////////////////////
    String getCurrentUser(){
    return _currentUser;
  }

  void setCurrentUser(String currentUser){
    _currentUser = currentUser;
    notifyListeners();
  }
  ///////////////////////////////////////
  bool getIsFailLogin(){
    return _isFailLogin!;
  }

  void setIsFailLogin(bool isFaillogin){
    _isFailLogin = isFaillogin;
    notifyListeners();
  }
  ///////////////////////////////////////
  bool getScreenIndex(){
    return _screenIndex;
  }

  void setScreenIndex(bool screen){
    _screenIndex = screen;
    notifyListeners();
  }
  //////////////////////////////////////////
  int getCategoryIndex(){
    return _categoryIndex;
  }

  void setCategoryindex(int index){
    _categoryIndex = index ;
    notifyListeners();
  }
  ////////////////////////////////////////////
  String getCategoryName(){
    return _categoryName;
  }

  void setCategoryName(String name){
    _categoryName = name ;
    notifyListeners();
  }
}