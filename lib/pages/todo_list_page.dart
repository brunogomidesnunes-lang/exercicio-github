import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      labelText: 'Tarefa',
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                      onChanged: onChanged,
                  ),
                ),

                SizedBox(width: 12,),
                ElevatedButton(onPressed: entrar, child: Text('+'))
              ],
            ),
          )),
    );
  }
  void entrar(){
    String text = textController.text;
    print(text);

  }

  void onChanged(String text){
    print(text);
  }

}