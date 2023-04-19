import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../database/todo_database.dart';
import '../model/todo_model.dart';


class TodoProvider with ChangeNotifier {
  final TodoDatabase todoDatabase = TodoDatabase();
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> addTodoToDatabase(Todo todo) async {
    await todoDatabase.saveTodoToDatabase(todo);
    getTodosFromDatabase();
  }

  Future<void> getTodosFromDatabase() async {
    _todos = await todoDatabase.getTodosFromDatabase();
    notifyListeners();
  }

  void toggleTodoCompletion(int index) {
    _todos[index].completed = !_todos[index].completed;
    updateTodoInDatabase(index, _todos[index]);
  }

  void removeTodoFromList(int index) {
    _todos.removeAt(index);
    //updateTodoInDatabase(index, _todos[index]);
    notifyListeners();
  }

  void editTodoInList(int index, Todo todo) {
    _todos[index] = todo;
    updateTodoInDatabase(index, todo);
  }

  Future<void> updateTodoInDatabase(int index, Todo todo) async {
    final box = await Hive.openBox<Todo>('todoBox');
    await box.putAt(index, todo);
    await box.close();
    getTodosFromDatabase();
  }
}

