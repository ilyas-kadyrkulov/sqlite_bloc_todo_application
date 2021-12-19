import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Todo {
  String id;
  String title;
  DateTime dueDate;
  String note;

  Todo({this.id, @required this.title, @required this.dueDate, @required this.note});
  Todo.newTodo() {
    title = "";
    dueDate = DateTime.now();
    note = "";
  }

  assignUUID() {
    id = Uuid().v4();
  }

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
    id: json["id"],
    title: json["title"],
    dueDate: DateTime.parse(json["dueDate"]).toLocal(),
    note: json["note"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "dueDate": dueDate.toUtc().toString(),
    "note": note
  };
}