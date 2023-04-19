import 'package:hive/hive.dart';

class Todo {
  final String title;
  final String description;
  bool completed;

  Todo({required this.title, required this.description, this.completed = false});
}

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final title = reader.read();
    final description = reader.read();
    final completed = reader.readBool();
    return Todo(
      title: title,
      description: description,
      completed: completed,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.write(obj.title);
    writer.write(obj.description);
    writer.writeBool(obj.completed);
  }
}