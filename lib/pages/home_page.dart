import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_bloc/bloc/task/task_state.dart';

import '../bloc/task/task_bloc.dart';
import '../bloc/task/task_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textFieldController = TextEditingController();

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TaskBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App Bloc'),
        elevation: 3,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Dismissible(
                    key: ValueKey<int>(state.tasks[index].id),
                    onDismissed: (_) {
                      bloc.add(DeleteTask(state.tasks[index].id));
                    },
                    child: CheckboxListTile(
                      title: Text(state.tasks[index].title),
                      onChanged: (value) {
                        bloc.add(
                          ToggleTaskCompletion(
                            state.tasks[index].id,
                          ),
                        );
                      },
                      value: state.tasks[index].isCompleted,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Inclua algo na lista'),
                actionsAlignment: MainAxisAlignment.center,
                content: TextField(
                  onChanged: (value) {},
                  controller: textFieldController,
                  decoration: const InputDecoration(hintText: "Nome da lista"),
                ),
                actions: [
                  MaterialButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                      textFieldController.clear();
                    },
                  ),
                  MaterialButton(
                    child: const Text('Incluir'),
                    onPressed: () {
                      bloc.add(AddTask(textFieldController.text));
                      Navigator.pop(context);
                      textFieldController.clear();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
