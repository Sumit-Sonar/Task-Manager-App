import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/provider.dart';
import 'package:task_manager_app/taskseditui.dart';
import 'package:task_manager_app/taskslistui.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;

  void onTapIndexed(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TaskProvider().loadTasks();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Task Manager App"),
        ),
        backgroundColor: const Color(0xFFFEDBD0),
        body: IndexedStack(
          index: selectedIndex,
          children: const <Widget>[TakskListUI(), TasksEditUI()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: Colors.black,
              ),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                label: 'Edit')
          ],
          currentIndex: selectedIndex,
          onTap: onTapIndexed,
          selectedItemColor: Colors.black,
        ),
      ),
    );
  }
}
