

class ToDo {
  String title;
  bool isDone;
  DateTime timestamp;

  ToDo({
    required this.title,
    this.isDone = false,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  void toggleDone() {
    isDone = !isDone;
  }
}

