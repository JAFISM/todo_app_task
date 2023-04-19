import 'package:hive/hive.dart';

import '../model/todo_model.dart';


const String _todoBox = 'todoBox';

class TodoDatabase {
  Future<void> saveTodoToDatabase(Todo todo) async {
    final box = await Hive.openBox<Todo>(_todoBox);
    await box.add(todo);
    await box.close();
  }

  Future<List<Todo>> getTodosFromDatabase() async {
    final box = await Hive.openBox<Todo>(_todoBox);
    final todos = box.values.toList();
    await box.close();
    return todos;
  }
}