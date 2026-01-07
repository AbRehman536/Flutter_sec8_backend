import 'package:flutter/material.dart';
import 'package:flutter_sec8_backend/provider/user_provider.dart';
import 'package:flutter_sec8_backend/views/update_profile.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(children: [
        Text("Name: ${userProvider.getUser().name.toString()}"),
        Text("Email: ${userProvider.getUser().email.toString()}"),
        Text("Address: ${userProvider.getUser().address.toString()}"),
        Text("Phone: ${userProvider.getUser().phone.toString()}"),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()));
        }, child: Text("Update Profile"))
      ],),
    );
  }
}
