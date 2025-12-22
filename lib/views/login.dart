import 'package:flutter/material.dart';
import 'package:flutter_sec8_backend/services/auth.dart';
import 'package:flutter_sec8_backend/views/get_all_task.dart';
import 'package:flutter_sec8_backend/views/register.dart';
import 'package:flutter_sec8_backend/views/reset_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(children: [
        TextField(controller: emailController,),
        TextField(controller: passwordController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading= true;
                setState(() {});
                await AuthServices().loginUser(
                    email: emailController.text,
                    password: passwordController.text)
                    .then((value){
                      isLoading= false;
                      setState(() {});
                      if(value.emailVerified == true){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllTask()));
                      }else{
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Kindly verify your email"),
                            actions: [TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("Okay"))],
                          );
                        }, );
                      }
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()))
                );
              }
        }, child: Text("Login")),
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
        }, child: Text("Register")),
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
        }, child: Text("Forget Password")),
      ],),
    );
  }
}
