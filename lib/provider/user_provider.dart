import 'package:flutter/foundation.dart';
import 'package:flutter_sec8_backend/model/user.dart';

class UserProvider extends ChangeNotifier{
  UserModel _userModel = UserModel();

  ///set User
  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  ///get User
  UserModel getUser() => _userModel;
}