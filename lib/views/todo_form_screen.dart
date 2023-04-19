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
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.indigo.withOpacity(0.3)
              ),
              child: TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
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
            ),
            const SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              height: MediaQuery.of(context).size.height/3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.indigo.withOpacity(0.3)
              ),
              child: TextFormField(
                initialValue: _description,
                maxLines: 10,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10,top: 8),
                  hintText: 'Description',
                  border: InputBorder.none
                ),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.todo != null ? 'update' : 'save')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
