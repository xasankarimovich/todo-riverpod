import 'package:river_pod_todo/data/services/todo_database.dart';
import 'package:riverpod/riverpod.dart';
import '../model/todo_model.dart';
final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  Future<void> loadTodos() async {
    final todos = await TodoDatabase.instance.readAllTodos();
    state = todos;
  }

  Future<void> addTodo(Todo todo) async {
    await TodoDatabase.instance.create(todo);
    loadTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await TodoDatabase.instance.update(todo);
    loadTodos();
  }

  Future<void> deleteTodo(int id) async {
    await TodoDatabase.instance.delete(id);
    loadTodos();
  }
}
