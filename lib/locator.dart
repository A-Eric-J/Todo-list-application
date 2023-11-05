import 'package:get_it/get_it.dart';
import 'package:todo_list_application/services/navigation_service.dart';

/// get_it package => https://pub.dev/packages/get_it
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
