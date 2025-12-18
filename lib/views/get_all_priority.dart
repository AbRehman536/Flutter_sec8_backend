import 'package:flutter/material.dart';
import 'package:flutter_sec8_backend/model/priority.dart';
import 'package:flutter_sec8_backend/services/priority.dart';
import 'package:flutter_sec8_backend/views/create_priority.dart';
import 'package:flutter_sec8_backend/views/get_priority_task.dart';
import 'package:provider/provider.dart';

class GetAllPriority extends StatelessWidget {
  const GetAllPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Priority"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePriority(model: PriorityModel(), isUpdateMode: false)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: PriorityServices().getAllPriorities(),
          initialData: [PriorityModel()],
        builder: (context, child){
            List<PriorityModel> priorityList = context.watch<List<PriorityModel>>();
            return ListView.builder(
              itemCount: priorityList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.task_alt),
                  title: Text(priorityList[index].name.toString()),
                  trailing: Row(children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityModel(), isUpdateMode: true)));
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: ()async{
                      try{
                        await PriorityServices().deletePriority(priorityList[index].docId.toString());
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPriorityTask(model: PriorityModel())));
                    }, icon: Icon(Icons.arrow_forward)),
                  ],),
                );
              },);
        },
      )
    );
  }
}
