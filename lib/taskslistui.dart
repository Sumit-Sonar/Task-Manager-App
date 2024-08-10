import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/provider.dart';

class TakskListUI extends StatefulWidget {
  const TakskListUI({super.key});

  @override
  State<TakskListUI> createState() => _TakskListUIState();
}

class _TakskListUIState extends State<TakskListUI> {
  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );
    final provider = Provider.of<TaskProvider>(context);
    final tasks = provider.tasks;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color(0xFFffeaa7),
              borderRadius: BorderRadius.circular(12)),
          child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: ((context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Switch(
                        thumbIcon: thumbIcon,
                        value: task.isCompleted,
                        onChanged: (bool value) {
                          setState(() {
                            provider.isTaskComplete(task.id);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          provider.deleteTask(task.id);
                        },
                      ),
                    ],
                  ),
                );
              })),
        ),
      ),
    );
  }
}
