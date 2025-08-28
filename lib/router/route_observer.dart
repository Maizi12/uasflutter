import 'package:digit/providers/navigation_history_provider.dart';
import 'package:flutter/material.dart';

class AppRouteObserver extends NavigatorObserver {
  final NavigationHistory navigationHistory;

  AppRouteObserver(this.navigationHistory);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    // Call the update method whenever a new route is pushed.
    navigationHistory.updateRoutes(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      navigationHistory.updateRoutes(newRoute);
    }
  }
}
