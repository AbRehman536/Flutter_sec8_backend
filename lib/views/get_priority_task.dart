import 'package:flutter/material.dart';
import 'package:flutter_sec8_backend/model/priority.dart';
import 'package:flutter_sec8_backend/model/task.dart';
import 'package:flutter_sec8_backend/services/task.dart';
import 'package:provider/provider.dart';

class GetPriorityTask extends StatelessWidget {
  final PriorityModel model;
  const GetPriorityTask({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.name} Priority Task"),

      ),
      body: StreamProvider.value(
          value: TaskService().getTaskByPriorityID(model.docId.toString()),
          initialData: [TaskModel()],
       builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.propane_outlined),
                title: Text(taskList[index].name.toString()),
                subtitle: Text(taskList[index].description.toString()),
              );
            },);
       },
      ),
    );
  }
}
