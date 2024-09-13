import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/model/todo_model.dart';
import '../../data/services/riverpod_provider.dart';
class TodoScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (value) {
                ref.read(todoListProvider.notifier).updateTodo(
                  Todo(
                    id: todo.id,
                    title: todo.title,
                    isCompleted: value!,
                  ),
                );
              },
            ),
            onLongPress: () => ref.read(todoListProvider.notifier).deleteTodo(todo.id!),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodoDialog(context, ref),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodoDialog(BuildContext context, WidgetRef ref) {
    final _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter todo title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(todoListProvider.notifier).addTodo(
                  Todo(
                    title: _controller.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
