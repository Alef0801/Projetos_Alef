import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [];

  void addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].toggleDone();
    });
  }

  void showAddTaskDialog() {
    String newTaskTitle = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nova Tarefa'),
        content: TextField(
          autofocus: true,
          onChanged: (value) => newTaskTitle = value,
          onSubmitted: (_) {
            if (newTaskTitle.trim().isNotEmpty) {
              addTask(newTaskTitle.trim());
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (newTaskTitle.trim().isNotEmpty) {
                addTask(newTaskTitle.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: tasks.isEmpty
          ? const Center(child: Text('Nenhuma tarefa adicionada ainda.'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => TaskTile(
                task: tasks[index],
                onChanged: () => toggleTask(index),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
