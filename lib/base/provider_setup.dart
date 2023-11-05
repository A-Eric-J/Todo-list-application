import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list_application/providers/todo_list_provider.dart';

/// provider_setup initializes the providers that are using in your app

List<SingleChildWidget> providers = [

  ListenableProvider.value(value: TodoListProvider()),
];

