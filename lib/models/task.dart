class Task {
  bool isDone;

  String title;

  Task({required this.title, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
