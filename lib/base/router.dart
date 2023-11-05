
import 'package:flutter/material.dart';
import 'package:todo_list_application/const_values/route_paths.dart';
import 'package:todo_list_application/ui/views/main_view.dart';

/// All the Routes for navigating are placed here
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.mainViewPath:
        return MaterialPageRoute(builder: (_) => const MainView());

      /// this commented code is for when we need to pass data to our destination path and
      /// getting the data from settings.arguments
      // case RoutePaths.testScreenPath:
      //   var test = settings.arguments as TestModel;
      //   return MaterialPageRoute(builder: (_) => TestScreen(test: test,));

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
