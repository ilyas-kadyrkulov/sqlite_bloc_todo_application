import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite_bloc_todo_application/configs/const_text.dart';
import 'package:sqlite_bloc_todo_application/models/todo.dart';
import 'package:sqlite_bloc_todo_application/repositories/todo_bloc.dart';

class TodoEditView extends StatelessWidget {

  final DateFormat _format = DateFormat("dd-MM-yyyy HH:mm");

  final TodoBloc todoBloc;
  final Todo todo;
  final Todo _newTodo = Todo.newTodo();

  TodoEditView({Key key, @required this.todoBloc, @required this.todo}){
    _newTodo.id = todo.id;
    _newTodo.title = todo.title;
    _newTodo.dueDate = todo.dueDate;
    _newTodo.note = todo.note;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ConstText.todoEditView)),
      body: Container(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: <Widget>[
            _titleTextFormField(),
            _dueDateTimeFormField(),
            _noteTextFormField(),
            _confirmButton(context)
          ],
        ),
      )
    );
  }

  Widget _titleTextFormField() => TextFormField(
    decoration: InputDecoration(labelText: "Title"),
    initialValue: _newTodo.title,
    onChanged: _setTitle,
  );
  
  void _setTitle(String title) {
    _newTodo.title = title;
  }

  Widget _dueDateTimeFormField() => DateTimeField(
    format: _format,
    decoration: InputDecoration(labelText: "Date"),
    initialValue: _newTodo.dueDate ?? DateTime.now(),
    onChanged: _setDueDate,
    onShowPicker: (context, currentValue) async {
      final date = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        initialDate: currentValue ?? DateTime.now(),
        lastDate: DateTime(2100));
      if (date != null) {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(
              currentValue ?? DateTime.now()),
        );
        return DateTimeField.combine(date, time);
      } else {
        return currentValue;
      }
    }
  );
 
  void _setDueDate(DateTime dt) {
    _newTodo.dueDate = dt;
  }

  Widget _noteTextFormField() => TextFormField(
    decoration: InputDecoration(labelText: "Note"),
    initialValue: _newTodo.note,
    maxLines: 3,
    onChanged: _setNote,
  );

  void _setNote(String note) {
    _newTodo.note = note;
  }

  Widget _confirmButton(BuildContext context) => RaisedButton.icon(
    icon: Icon(
      Icons.tag_faces,
      color: Colors.white,
    ),
    label: Text("Submit"),
    onPressed: () { 
      if (_newTodo.id == null) {
        todoBloc.create(_newTodo);
      } else {
        todoBloc.update(_newTodo);
      }
      
      Navigator.of(context).pop();
    },
    shape: StadiumBorder(),
    color: Colors.green,
    textColor: Colors.white,
  );
}
