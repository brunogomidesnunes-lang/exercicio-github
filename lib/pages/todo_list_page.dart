import 'package:flutter/material.dart';
import 'package:lista_tarefas2/repositories/todo_repository.dart';

import '../models/todo.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});


  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();


  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  String? errorText;


  @override
  void initState(){
    super.initState();

    todoRepository.getTodoList().then((value){
      setState(() {
        todos = value;
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Tarefas'),
          centerTitle: false,
         backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Ex. Estudar',
                          errorText: errorText,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        if(text.isEmpty){
                          setState(() {
                            errorText = 'O texto não pode ser vazio!';
                          });
                          return;
                        }
                        setState(() {
                          Todo newTodo = Todo(
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          todos.add(newTodo);
                          errorText = null;
                        });
                        todoController.clear();
                        todoRepository.saveTodoList(todos);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        minimumSize: const Size(55, 55),
                      ),
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 15),
                Flexible(
                  child: ListView(
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                          onEdit: onEdit,
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} tarefas pendentes',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: showDeleteTodosConfirmationDialog,
                      child: Text('Limpar tudo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        minimumSize: const Size(55, 55),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onEdit(Todo todo) {
    // Cria um controlador de texto e já o preenche com o título atual da tarefa
    final TextEditingController editController =
    TextEditingController(text: todo.title);

    // Exibe um diálogo de alerta
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Tarefa'),
          // Campo de texto para edição
          content: TextField(
            controller: editController,
            autofocus: true, // Foca automaticamente no campo
            decoration: InputDecoration(
              labelText: 'Novo título',
              hintText: 'Digite o novo título da tarefa',
            ),
          ),
          actions: [
            // Botão de Cancelar
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Apenas fecha o diálogo
              },
            ),
            // Botão de Salvar
            TextButton(
              child: Text('Salvar'),
              onPressed: () {
                String newTitle = editController.text;
                if (newTitle.isNotEmpty) {
                  // Se o texto não estiver vazio
                  setState(() {
                    // Atualiza o título do objeto 'todo'
                    todo.title = newTitle;
                    // Opcional: atualizar a data da modificação
                    // todo.dateTime = DateTime.now();
                  });
                  // Salva a lista inteira (com o item modificado) na persistência
                  todoRepository.saveTodoList(todos);
                  Navigator.of(context).pop(); // Fecha o diálogo
                }
                // Você pode adicionar um 'errorText' no diálogo aqui também, se desejar
              },
            ),
          ],
        );
      },
    );
  }




  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa ${todo.title} foi removida com sucesso!'),
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
            todoRepository.saveTodoList(todos);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
















  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar tudo?'),
        content: Text('Deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
          onPressed: () {Navigator.of(context).pop();
            },
              child: Text('Cancelar'),
          style: TextButton.styleFrom(foregroundColor: Colors.black),),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deletedAllTodos();
                },
              child: Text('Limpar Tudo',),
          style: TextButton.styleFrom(foregroundColor: Colors.black)
          ),
        ],
      ),
    );
  }
  void deletedAllTodos(){
    setState(() {
      todos.clear();
    });
    todoRepository.saveTodoList(todos);
  }
}
