import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas2/pages/todo_list_page.dart';

void main(){
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListPage(),
    );
  }
}


