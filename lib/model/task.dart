// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? docId;
  final String? name;
  final String? description;
  final List<dynamic>? favorite;
  final String? priorityID;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.name,
    this.description,
    this.priorityID,
    this.favorite,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    docId: json["docID"],
    name: json["name"],
    priorityID: json["priorityID"],
    description: json["description"],
    favorite: json["favorite"] == null ? [] : List<dynamic>.from(json["favorite"]!.map((x) => x)),
    isCompleted: json["isCompleted"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docID": taskID,
    "name": name,
    "priorityID": priorityID,
    "description": description,
    "favorite": favorite == null ? [] : List<dynamic>.from(favorite!.map((x) => x)),
    "isCompleted": isCompleted,
    "createdAt": createdAt,
  };
}
