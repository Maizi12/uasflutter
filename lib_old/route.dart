import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_flutter/dependencies_injection.dart';
import 'package:uas_flutter/domain/services/hive/hive.dart';
import 'package:uas_flutter/main.dart';
import 'package:uas_flutter/pages/all-coa.dart';
import 'package:uas_flutter/pages/all-tx.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';
import 'package:uas_flutter/view/transaksi/editTransaksi.dart';
import 'package:uas_flutter/view/transaksi/transaksi2.dart';
import 'package:uas_flutter/view/beranda/beranda.dart';
import 'package:uas_flutter/view/login/login.dart';
import 'package:uas_flutter/view/regis/regis.dart';

/// Navigation history tracker for the application
class NavigationHistory extends ChangeNotifier {
  String? _previousRoute;
  String? _currentRoute;

  String? get previousRoute => _previousRoute;
  String? get currentRoute => _currentRoute;

  /// Update the current route and store the previous one
  void updateRoute(String newRoute) {
    _previousRoute = _currentRoute;
    _currentRoute = newRoute;
    notifyListeners();
  }
}

/// Global navigation history instance
final navigationHistory = NavigationHistory();

/// Custom navigator observer to track route changes
class CustomGoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      navigationHistory.updateRoute(route.settings.name!);
    }
    super.didPush(route, previousRoute);
  }
}

/// Application routing configuration
class Routing {
  static late BuildContext context;
  
  Routing.setStream(BuildContext ctx) {
    context = ctx;
  }

  /// Main router configuration for the application
  static final GoRouter router = GoRouter(
    observers: [CustomGoRouterObserver()],
    navigatorKey: navigatorKey,
    routes: [
      // Authentication routes
      GoRoute(
        path: LoginApp.routeName,
        name: LoginApp.routeName,
        builder: (context, state) => const LoginApp(),
      ),
      GoRoute(
        path: RegisApp.routeName,
        name: RegisApp.routeName,
        builder: (context, state) => const RegisApp(),
      ),
      
      // Main application routes
      GoRoute(
        path: Beranda.routeName,
        name: Beranda.routeName,
        builder: (context, state) => Beranda(),
      ),
      GoRoute(
        path: Transaksi2App.routeName,
        name: Transaksi2App.routeName,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => sl<TransaksiCubit>(),
            child: Transaksi2App(),
          );
        },
      ),
      
      // Transaction management routes
      GoRoute(
        path: AllTxApp.routeName,
        name: AllTxApp.routeName,
        builder: (context, state) => AllTxApp(),
      ),
      
      // Chart of Accounts routes
      GoRoute(
        path: AllCoaApp.routeName,
        name: AllCoaApp.routeName,
        builder: (context, state) => AllCoaApp(),
      ),
    ],
    debugLogDiagnostics: kDebugMode,
    initialLocation: LoginApp.routeName,
  );
}
