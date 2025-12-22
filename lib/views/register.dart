import 'package:flutter/material.dart';
import 'package:flutter_sec8_backend/model/user.dart';
import 'package:flutter_sec8_backend/services/auth.dart';
import 'package:flutter_sec8_backend/services/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registeration"),
      ),
      body: Column(children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(label: Text("Name")),),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          decoration: InputDecoration(label: Text("Email")),),
        TextField(
          controller: passwordController,
          obscureText: false,
          decoration: InputDecoration(label: Text("Password")),),
        TextField(
          controller: addressController,
          decoration: InputDecoration(label: Text("Address")),),
        TextField(
          keyboardType: TextInputType.phone,
          controller: phoneController,
          decoration: InputDecoration(label: Text("Contact")),),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await AuthServices().registerUser(
                    email: emailController.text,
                    password: passwordController.text)
                    .then((val){
                      UserServices().createUser(
                        UserModel(
                          docId: val!.uid.toString(),
                          name: nameController.text.toString(),
                          email: emailController.text.toString(),
                          phone: phoneController.text.toString(),
                          address: addressController.text.toString())
                      ).then((value){
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                          builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text("Register Successfully"),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=Login()));
                                  }, child: Text("Okay"))
                                ],
                              );
                          },);
                      });
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString()))
                );
              }
        }, child: Text("Register"))
      ],),
    );
  }
}
