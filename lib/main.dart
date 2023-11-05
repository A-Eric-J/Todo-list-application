import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/base/provider_setup.dart';
import 'package:todo_list_application/locator.dart';
import 'package:todo_list_application/base/router.dart' as router;
import 'package:todo_list_application/services/navigation_service.dart';
import 'package:todo_list_application/ui/views/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  return runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      onGenerateRoute: router.Router.generateRoute,
      debugShowCheckedModeBanner: true,
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: const MainView(),
    );
  }
}
