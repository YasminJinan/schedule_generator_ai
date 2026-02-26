import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';

class AddTaskCard extends StatefulWidget {
  final Function(Task)  onAddtask;
  const AddTaskCard({super.key, required this.onAddtask});

  @override
  State<AddTaskCard> createState() => _AddTaskCardState();
}

class _AddTaskCardState extends State<AddTaskCard> {
  final taskController = TextEditingController();
  final durationController = TextEditingController();
  final deadlineController = TextEditingController();
  String? priority;

  @override
  void dispose() {
    // agar nggak ada cache data saat masuk ke list task dan siap menerima task baru
    taskController.dispose();
    durationController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  void _submit() {
    if (taskController.text.isNotEmpty && durationController.text.isNotEmpty 
    && deadlineController.text.isNotEmpty && priority != null) {
      widget.onAddtask(Task(
        name: taskController.text,
        priority: priority!,
        duration: int.tryParse(durationController.text) ?? 5,
        deadline: deadlineController.text
      ));

      // buat bersihin cache untuk function submit
      taskController.clear();
      durationController.clear();
      deadlineController.clear();
      setState(() => priority = null);
    }
  }

  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.playlist_add_check_circle_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 8,),
                Text(
                  'Add task',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(height: 12,),
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Task name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.task_alt_rounded)
              ),
              // kalo di enter biar dia next ke textfield yg dibawah
              textInputAction: TextInputAction.next,
            ),
             SizedBox(height: 12,),
            
            // Duration
            TextField(
              controller: durationController,
              decoration: InputDecoration(
                labelText: 'Duration (minute)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer_outlined)
              ),
              // keyboard type = number
              keyboardType: TextInputType.number,
              // kalo di enter biar dia next ke textfield yg dibawah
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 12,),
            TextField(
              controller: deadlineController,
              decoration: InputDecoration(
                labelText: 'Deadline',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.event_outlined)
              ),
              textInputAction: TextInputAction.done, // keyboradnya ketutup
            ),
            SizedBox(height: 12,),
            DropdownMenu<String>(
              leadingIcon: Icon(Icons.flag),
             initialSelection: priority,       
             dropdownMenuEntries: const [
               DropdownMenuEntry(value: "Low", label: "Low"),
               DropdownMenuEntry(value: "Medium", label: "Medium"),
               DropdownMenuEntry(value: "High", label: "High"),
             ],
             onSelected: (value) {
               setState(() {
                 priority = value;
               });
             },
           ),
           SizedBox(height: 16,),
           FilledButton.icon(
            onPressed: _submit,
            icon: Icon(Icons.add_rounded),
            label: Text('Add Task'),
           )
          ],
        ),
      ),
    );
  }
}