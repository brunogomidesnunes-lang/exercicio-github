import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import 'package:slideable/Slideable.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo, required this.onDelete});

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Slideable(
      items: <ActionItems>[
        ActionItems(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPress: () {
            onDelete(todo);
            print('Item Deletado!');
          },
          backgroudColor: Colors.transparent,
        ),
        ActionItems(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPress: () {
            print('Abrir tela de Edição para: ${todo.title}');
          },
          backgroudColor: Colors.transparent,
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(todo.dateTime),
                style: TextStyle(fontSize: 12),
              ),
              Text(
                todo.title,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    ); // Parêntese extra removido aqui!
  }
}
