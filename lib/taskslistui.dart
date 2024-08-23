import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/provider.dart';

class TaskListUI extends StatefulWidget {
  const TaskListUI({super.key});

  @override
  State<TaskListUI> createState() => _TaskListUIState();
}

class _TaskListUIState extends State<TaskListUI> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final tasks = provider.tasks;


    void showDeleteDialog(
        BuildContext context, TaskProvider provider, String taskId) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Delete Task",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text("Are you sure you want to delete this task?"),
              actions: [
                TextButton(
                  child: Text("Cancel", style: TextStyle(color: Colors.grey)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Yes", style: TextStyle(color: Colors.redAccent)),
                  onPressed: () {
                    provider.deleteTask(taskId);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Text(
                        'No tasks available. Add a new task!',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 10),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: task.isCompleted
                                      ? Colors.grey
                                      : Colors.black87,
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                task.description,
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 14),
                              ),
                            ),
                            // to take up the minimum width
                            trailing: IntrinsicWidth( 
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Switch(
                                    activeColor: Colors.teal,
                                    inactiveTrackColor: Colors.grey.shade300,
                                    value: task.isCompleted,
                                    onChanged: (bool value) {
                                      setState(() {
                                        provider.isTaskComplete(task.id);
                                        provider.isTaskDone(task.id, value);
                                      });
                                    },
                                  ),
                                  SizedBox(width: 8),
                                  // Text indicating completion status
                                  AnimatedOpacity(
                                    opacity: task.isDone ? 1.0 : 0.0,
                                    duration: Duration(milliseconds: 300),
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline),
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      showDeleteDialog(
                                          context, provider, task.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
