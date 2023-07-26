sealed class TaskEvent {}

class ToggleTaskCompletion extends TaskEvent {
  final int taskId;

  ToggleTaskCompletion(this.taskId);
}

class AddTask extends TaskEvent {
  final String title;

  AddTask(this.title);
}

class DeleteTask extends TaskEvent {
  final int taskId;

  DeleteTask(this.taskId);
}
