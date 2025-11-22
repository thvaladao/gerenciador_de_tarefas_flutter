import 'package:flutter/material.dart';

class Tarefa {
  String nome;
  bool concluida;

  Tarefa({required this.nome, this.concluida = false});
}

class TaskListScreen extends StatefulWidget {
  final DateTime data;

  const TaskListScreen({super.key, required this.data});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Tarefa> tarefas = [];
  final TextEditingController controller = TextEditingController();

  void adicionarTarefa() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nova tarefa"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Descrição da tarefa"),
        ),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Adicionar"),
            onPressed: () {
              setState(() {
                tarefas.add(Tarefa(nome: controller.text));
                ordenarLista();
                controller.clear();
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void ordenarLista() {
    tarefas.sort((a, b) {
      if (a.concluida == b.concluida) {
        return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
      }
      return a.concluida ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tarefas de ${widget.data.day}/${widget.data.month}/${widget.data.year}",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarTarefa,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (_, i) {
          final t = tarefas[i];
          return Card(
            child: ListTile(
              title: Text(
                t.nome,
                style: TextStyle(
                  decoration: t.concluida
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              leading: Checkbox(
                value: t.concluida,
                onChanged: (v) {
                  setState(() {
                    t.concluida = v ?? false;
                    ordenarLista();
                  });
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    tarefas.removeAt(i);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
