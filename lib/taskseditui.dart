import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/provider.dart';
import 'package:task_manager_app/taskmodel.dart';

class TasksEditUI extends StatefulWidget {
  const TasksEditUI({super.key});

  @override
  State<TasksEditUI> createState() => _TasksEdituiState();
}

class _TasksEdituiState extends State<TasksEditUI> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
        backgroundColor: const Color(0xFFb1decf),
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 15),
          child: Container(
            height: 270,
            width: 330,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Add Tasks",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Task',
                        labelStyle: TextStyle(color: Colors.black)),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Description',
                        labelStyle: TextStyle(color: Colors.black)),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final title = titleController.text.trim();
                      if (title.isNotEmpty) {
                        final task = Task(
                            id: DateTime.now().toString(),
                            title: titleController.text,
                            description: descriptionController.text);
                        provider.addTask(task);
                        titleController.clear();
                        descriptionController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('$title Task added successfully'),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Task feild should not be empty'),
                        ));
                      }
                    },
                    child: Text("Add"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
