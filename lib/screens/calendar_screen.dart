import 'package:flutter/material.dart';
import 'task_list_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime diaSelecionado = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendário")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TaskListScreen(data: diaSelecionado),
            ),
          );
        },
      ),
      body: CalendarDatePicker(
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialDate: DateTime.now(),
        onDateChanged: (d) {
          setState(() {
            diaSelecionado = d;
          });
        },
      ),
    );
  }
}
