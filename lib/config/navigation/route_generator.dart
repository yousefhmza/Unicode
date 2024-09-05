import 'package:flutter/material.dart';
import 'package:unicode/modules/todos/views/screens/todos_screen.dart';

import '../../modules/splash/views/screens/splash_screen.dart';
import '../../modules/auth/views/screens/auth_screen.dart';
import '../../modules/layout/views/screens/layout_screen.dart';
import 'navigation.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    final Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case Routes.splashScreen:
        return platformPageRoute(const SplashScreen(), settings);
      case Routes.authScreen:
        return platformPageRoute(const AuthScreen(), settings);
      case Routes.layoutScreen:
        return platformPageRoute(LayoutScreen(requireSyncData: arguments!["requireSyncData"]), settings);
      case Routes.todosScreen:
        return platformPageRoute(TodosScreen(category: arguments!["category"]), settings);
      default:
        return platformPageRoute(const Scaffold(), settings);
    }
  }
}
