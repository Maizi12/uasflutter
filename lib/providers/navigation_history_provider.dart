import 'package:flutter/material.dart';

class NavigationHistory extends ChangeNotifier {
  String? _previousRoute;
  String? _currentRoute;

  String? get previousRoute => _previousRoute;
  String? get currentRoute => _currentRoute;

  /// Updates the route history and notifies listeners.
  void updateRoutes(Route? route) {
    if (route is PageRoute && route.settings.name != null) {
      // The new route becomes the current one,
      // and the old current one becomes the previous one.
      _previousRoute = _currentRoute;
      _currentRoute = route.settings.name;
      notifyListeners(); // This is crucial!
    }
  }
}
