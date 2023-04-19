import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/todo_model.dart';
import '../provider/todo_provider.dart';


class TodoFormScreen extends StatefulWidget {
  final Todo? todo;
  final int? index;

  const TodoFormScreen({this.todo, this.index});

  @override
  _TodoFormScreenState createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _title = widget.todo!.title;
      _description = widget.todo!.description;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final todo = Todo(
        title: _title,
        description: _description,
      );
      if (widget.index != null) {
        Provider.of<TodoProvider>(context, listen: false)
            .editTodoInList(widget.index!, todo);
      } else {
        Provider.of<TodoProvider>(context, listen: false)
            .addTodoToDatabase(todo);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo != null ? 'Edit Todo' : 'Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.todo != null ? 'update' : 'save')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
