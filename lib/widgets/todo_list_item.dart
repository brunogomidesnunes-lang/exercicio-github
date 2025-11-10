import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import 'package:slideable/Slideable.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onEdit,
    required this.onToggleComplete,
  });

  final Todo todo;
  final Function(Todo) onDelete;
  final Function(Todo) onEdit;
  final Function(Todo) onToggleComplete;

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
            onEdit(todo);
            print('Abrir tela de Edição para: ${todo.title}');
          },
          backgroudColor: Colors.transparent,
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),

        child: GestureDetector(
          onTap: () {
            onToggleComplete(todo);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
               color: todo.isDone ? Colors.grey[350] : Colors.grey[200],
            ),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),

              child: Row(
                children: [
                  Checkbox(
                    value: todo.isDone,
                    onChanged: (newValue) {
                     onToggleComplete(todo);
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy - HH:mm').format(todo.dateTime),
                          style: TextStyle(
                            fontSize: 12,
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        Text(
                          todo.title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: todo.isDone ? Colors.grey[700] : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}