import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_bloc/pages/home_page.dart';

import 'bloc/task/task_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoApp',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: BlocProvider<TaskBloc>(
        create: (BuildContext context) => TaskBloc(),
        child: const HomePage(),
      ),
    );
  }
}
