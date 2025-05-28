import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final ToDo task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final ValueChanged<String> onEdit;

  const TodoItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy/MM/dd – hh:mm a').format(task.timestamp);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: const Color(0xFFF5F5F5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: GestureDetector(
          onLongPress: () async {
            final newTitle = await showDialog<String>(
              context: context,
              builder: (context) {
                final controller = TextEditingController(text: task.title);
                return AlertDialog(
                  title: const Text('Edit Task'),
                  content: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Enter new title'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          Navigator.pop(context, controller.text.trim());
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              },
            );

            if (newTitle != null) {
              onEdit(newTitle);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: TextStyle(
                  fontSize: 16,
                  decoration: task.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
        leading: GestureDetector(
          onTap: onToggle,
          child: Icon(
            task.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            color: task.isDone ? Colors.green : Colors.grey,
            size: 28,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}