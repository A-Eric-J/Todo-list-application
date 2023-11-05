
import 'package:flutter/material.dart';
import 'package:todo_list_application/const_values/route_paths.dart';
import 'package:todo_list_application/enums/appbar_state.dart';
import 'package:todo_list_application/models/todo_list.dart';
import 'package:todo_list_application/ui/views/add_or_edit_todo_list.dart';
import 'package:todo_list_application/ui/views/main_view.dart';

/// All the Routes for navigating are placed here
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.mainViewPath:
        return MaterialPageRoute(builder: (_) => const MainView());
      case RoutePaths.addOrEditTodoListPath:
        var arguments = settings.arguments as Map;
        AppBarState appbarState = arguments['appbarState'];
        TodoList? todoList = arguments['todoList'];
        return MaterialPageRoute(builder: (_) =>  AddOrEditTodoList(appBar: appbarState,todoList: todoList,));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text(
                      'No route defined for ${settings.name}',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ));
    }
  }
}
