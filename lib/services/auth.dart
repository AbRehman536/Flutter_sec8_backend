import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  //register user
  Future<User> registerUser({
  required String email, required String password
}) async {
    try{
      UserCredential userCredential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();
      return userCredential.user!;
    }catch(e){
      throw e.toString();
    }
  }
  //login user
  Future<User> loginUser({
    required String email, required String password
  }) async {
    try{
      UserCredential userCredential =
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!;
    }catch(e){
      throw e.toString();
    }
  }
  //reset password
  Future resetPassword(String email) async {
    try{
      return await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
    }catch(e){
      throw e.toString();
    }
  }
}