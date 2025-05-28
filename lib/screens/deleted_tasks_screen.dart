import 'package:flutter/material.dart';
import '../models/todo.dart';

class DeletedTasksScreen extends StatelessWidget {
  final List<ToDo> deletedTasks;

  const DeletedTasksScreen({super.key, required this.deletedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text(
          'Deleted Tasks',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: deletedTasks.isEmpty
          ? const Center(child: Text('No deleted tasks'))
          : ListView.builder(
        itemCount: deletedTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              deletedTasks[index].title,
              style: const TextStyle(
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
            leading: const Icon(Icons.delete, color: Colors.red),
          );
        },
      ),
    );
  }
}
