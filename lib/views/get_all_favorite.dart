import 'package:flutter/material.dart';
import 'package:flutter_sec8_backend/model/task.dart';
import 'package:flutter_sec8_backend/services/task.dart';
import 'package:flutter_sec8_backend/views/create_task.dart';
import 'package:flutter_sec8_backend/views/update_task.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class GetFavoriteTask extends StatelessWidget {

  const GetFavoriteTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Get Favorite Task"),
        ),
        body: StreamProvider.value(
          value: TaskService().getAllFavorite(userProvider.getUser().docId.toString()),
          initialData: [TaskModel()],
          builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text(taskList[index].name.toString()),
                  subtitle: Text(taskList[index].description.toString()),

                );
              },);
          },
        )
    );
  }
}
