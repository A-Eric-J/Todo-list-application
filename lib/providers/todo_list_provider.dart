import 'package:flutter/cupertino.dart';
import 'package:todo_list_application/models/todo_list.dart';

class TodoListProvider extends ChangeNotifier {
  var _todoLists = <TodoList>[];
  void setTodoList(List<TodoList> newTodoLists){
    _todoLists = newTodoLists;
     notifyListeners();
  }
  List<TodoList> get todoLists => _todoLists;

  void addTodoList(TodoList newTodoList){
    _todoLists.add(newTodoList);
    notifyListeners();
  }
}