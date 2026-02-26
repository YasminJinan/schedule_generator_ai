import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';

class TaskListSection extends StatefulWidget {
  final Function(Task)  onAddtask;

  const TaskListSection({super.key, required this.onAddtask});

  @override
  State<TaskListSection> createState() => _AddTaskCardState();
}

class _AddTaskCardState extends State<TaskListSection> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}