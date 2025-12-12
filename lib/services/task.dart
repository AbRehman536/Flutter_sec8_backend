

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task.dart';

class TaskService{
  String taskCollection = "TaskCollection";
  //create Task
  Future createTask(TaskModel model) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(taskCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  //update Task
  Future updateTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .update({"name" :model.name, "description": model.description});
  }
  //delete Task
  Future deleteTask(String taskID)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .delete();
  }
  //mark as completed Task
  Future markAsCompleted(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .update({"isCompleted" :model.isCompleted});
  }
  //get all Task
  Stream<List<TaskModel>> getAllTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .snapshots()
        .map((taskList)=> taskList.docs
        .map((taskJson)=> TaskModel.fromJson(taskJson.data()))
        .toList()
    );
  }
  //get inCompleted Task
  Stream<List<TaskModel>> getInCompletedTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("isCompleted" ,isEqualTo: false)
        .snapshots()
        .map((taskList)=> taskList.docs
        .map((taskJson)=> TaskModel.fromJson(taskJson.data()))
        .toList()
    );
  }
  //get Completed Task
  Stream<List<TaskModel>> getCompletedTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("isCompleted", isEqualTo: true)
        .snapshots()
        .map((taskList)=> taskList.docs
        .map((taskJson)=> TaskModel.fromJson(taskJson.data()))
        .toList()
    );
  }
}