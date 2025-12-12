import 'package:flutter/material.dart';
import 'package:flutter_sec8_backend/model/task.dart';
import 'package:flutter_sec8_backend/services/task.dart';
import 'package:flutter_sec8_backend/views/create_task.dart';
import 'package:flutter_sec8_backend/views/get_completed_task.dart';
import 'package:flutter_sec8_backend/views/get_inCompleted_task.dart';
import 'package:flutter_sec8_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCompletedTaskTask()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GetInCompletedTaskTask()));
          }, icon: Icon(Icons.incomplete_circle)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: TaskService().getAllTask(),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                          value: taskList[index].isCompleted,
                          onChanged: (val)async{
                            try{
                              await TaskService().markAsCompleted(
                                  taskID: taskList[index].docId.toString(),
                                  isCompleted: val!,);
                            }catch(e){
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(e.toString())));
                            }
                          }),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(model: taskList[index])));
                      }, icon: Icon(Icons.edit)),
                      IconButton(onPressed: ()async{
                        try{
                          await TaskService().deleteTask(taskList[index].docId.toString());
                        }catch(e){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }, icon: Icon(Icons.delete)),
                    ],
                  )
                );
              },);
          },
      )
    );
  }
}
