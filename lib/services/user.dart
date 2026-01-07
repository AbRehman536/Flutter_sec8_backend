import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserServices{
  String userCollection = "UserCollection";
  ///Create User
  Future createUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));

  }

/// Get User By ID
    Future<UserModel> getUserByID(String userID)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .get()
        .then((userList) => UserModel.fromJson(userList.data()!));
    }
  //update Profile
  Future updateProfile(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .update({"name" :model.name, "phone": model.phone , "address" : model.address});
  }
  //delete Profile
  Future deleteProfile(String userID)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .delete();
  }
}