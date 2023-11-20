import 'package:flutter/cupertino.dart';

class TaskCheckingDetailScreen extends StatefulWidget {
  int task_id = 0;
  int completionInfo = 0;
  TaskCheckingDetailScreen({super.key, required this.task_id,required this.completionInfo});

  @override
  State<TaskCheckingDetailScreen> createState() => _TaskCheckingDetailScreenState();
}

class _TaskCheckingDetailScreenState extends State<TaskCheckingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
