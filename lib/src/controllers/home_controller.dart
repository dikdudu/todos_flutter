import 'package:flutter/cupertino.dart';
import 'package:list_builder/src/models/todo_model.dart';
import 'package:list_builder/src/repositories/todo_repository.dart';

class HomeController {
  List<TodoModel> todos = [];
  TodoRepository repository = TodoRepository();
  final state = ValueNotifier(HomeState.start);

  Future start() async {
    state.value = HomeState.loading;
    try {
      todos = await repository.fetchTodos();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
