import 'package:bloc/bloc.dart';
import 'package:todoapp_bloc/bloc/task/task_event.dart';
import 'package:todoapp_bloc/bloc/task/task_state.dart';

import '../../models/task_model.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState([])) {
    on<AddTask>(
      (event, emit) {
        final newTask = Task(id: state.tasks.length + 1, title: event.title);

        emit(TaskState([...state.tasks, newTask]));
      },
    );

    on<DeleteTask>((event, emit) {
      if (state.tasks.isNotEmpty) {
        final updatedTasks =
            state.tasks.where((task) => task.id != event.taskId).toList();
        emit(TaskState(updatedTasks));
      }
    });

    on<ToggleTaskCompletion>((event, emit) {
      final updatedTasks = state.tasks.map((task) {
        if (task.id == event.taskId) {
          return task.copyWith(isCompleted: !task.isCompleted);
        }
        return task;
      }).toList();

      emit(TaskState(updatedTasks));
    });
  }
}
