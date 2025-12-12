import 'package:flutter/material.dart';
import 'package:flutter_sec8_backend/model/task.dart';
import 'package:flutter_sec8_backend/services/task.dart';
import 'package:flutter_sec8_backend/views/create_task.dart';
import 'package:flutter_sec8_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetCompletedTaskTask extends StatelessWidget {
  const GetCompletedTaskTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Get Completed Task"),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
        },child: Icon(Icons.add),),
        body: StreamProvider.value(
          value: TaskService().getCompletedTask(),
          initialData: [TaskModel()],
          builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Icon(Icons.task),
                    title: Text(taskList[index].name.toString()),
                    subtitle: Text(taskList[index].description.toString()),

                );
              },);
          },
        )
    );
  }
}
