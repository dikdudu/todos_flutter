import 'package:flutter/material.dart';
import 'package:list_builder/src/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  _start() {
    return Container();
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _success() {
    return ListView.builder(
      itemCount: controller.todos.length,
      itemBuilder: (context, index) {
        var todo = controller.todos[index];
        return ListTile(
          leading: Checkbox(
            value: todo.completed,
            onChanged: (bool value) {},
          ),
          title: Text(controller.todos[index].title),
        );
      },
    );
  }

  _error() {
    return Center(
      child: RaisedButton(
        onPressed: controller.start,
        child: Text('Tentar Novamente'),
      ),
    );
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      case HomeState.error:
        return _error();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testando'),
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (BuildContext context, Widget child) {
          return stateManagement(controller.state.value);
        },
      ),
    );
  }
}
