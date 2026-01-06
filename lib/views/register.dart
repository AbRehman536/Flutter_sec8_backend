import 'package:flutter/material.dart';
import 'package:flutter_sec8_backend/model/user.dart';
import 'package:flutter_sec8_backend/services/user.dart';
import 'package:flutter_sec8_backend/views/login.dart';

import '../services/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(label: Text("Name")),),
        TextField(
          controller: emailController,
          decoration: InputDecoration(label: Text("Email")),),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(label: Text("Password")),),
        TextField(
          controller: cpasswordController,
          decoration: InputDecoration(label: Text("Confirm Password")),),
        TextField(
          controller: addressController,
          decoration: InputDecoration(label: Text("Address")),),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(label: Text("Phone")),),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await AuthServices().registerUser(
                    email: emailController.text,
                    password: passwordController.text)
                    .then((value)async{
                      await UserServices().createUser(
                        UserModel(
                          docId: value.uid.toString(),
                          name: nameController.text.toString(),
                          email: emailController.text.toString(),
                          address: addressController.text.toString(),
                          phone: phoneController.text.toString(),
                          createdAt: DateTime.now().millisecondsSinceEpoch
                        )).then((val){
                        isLoading = false;
                        setState(() {});
                          showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Register Successfully"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                                }, child: Text("Okay"))
                              ],
                            );
                          });
                      });
                });

              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
              }
        }, child: Text("Register"))
      ],),
    );
  }
}
