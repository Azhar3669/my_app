import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_item.dart';
import 'deleted_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<ToDo> _tasks = [];
  final List<ToDo> _deletedTasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _tasks.add(ToDo(title: _controller.text.trim()));
      _controller.clear();
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].toggleDone();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _deletedTasks.add(_tasks[index]);
      _tasks.removeAt(index);
    });
  }

  void _editTask(int index, String newTitle) {
    if (newTitle.trim().isEmpty) return;
    setState(() {
      _tasks[index].title = newTitle.trim();
    });
  }

  Widget _buildCurrentPage() {
    if (_selectedIndex == 0) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter new task',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[300],
                  ),
                  onSubmitted: (_) => _addTask(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _addTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[500],
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(

            child:
            _tasks.isEmpty
                ? const Center(child: Text('No tasks'))
                : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  task: _tasks[index],
                  onToggle: () => _toggleTask(index),
                  onDelete: () => _deleteTask(index),
                  onEdit: (newTitle) => _editTask(index, newTitle),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return DeletedTasksScreen(deletedTasks: _deletedTasks);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text(
          'To-Do App',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
         body: Padding(padding: const EdgeInsets.all (16),
           child: _buildCurrentPage(),
        ),

        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
          onTap: (index) => setState(()=>_selectedIndex= index),
              items:const[
                BottomNavigationBarItem(icon: Icon(Icons.task), label:'Task' ),
                BottomNavigationBarItem(icon: Icon(Icons.delete), label:'Deleted' ),
              ],

        ),
      );
    }
  }
