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

class NavigationHistory extends ChangeNotifier {
  String? _previousRoute;
  String? _currentRoute;

  String? get previousRoute => _previousRoute;
  String? get currentRoute => _currentRoute;

  void updateRoute(String newRoute) {
    _previousRoute = _currentRoute;
    _currentRoute = newRoute;
    notifyListeners();
  }
}

final navigationHistory = NavigationHistory();

class CustomGoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      navigationHistory.updateRoute(route.settings.name!);
    }
    super.didPush(route, previousRoute);
  }
}

class Routing {
  static late BuildContext context;
  Routing.setStream(BuildContext ctx) {
    context = ctx;
  }

  static final GoRouter router = GoRouter(
    observers: [CustomGoRouterObserver()],
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
          path: LoginApp.routeName,
          name: LoginApp.routeName,
          builder: (context, state) => const LoginApp()),
      GoRoute(
        path: AllTxApp.routeName,
        name: AllTxApp.routeName,
        builder: (context, state) {
          return AllTxApp();
        },
      ),
      // GoRoute(
      //   path: EditTransaksiApp.routeName,
      //   name: EditTransaksiApp.routeName,
      //   builder: (context, state) {
      //     return EditTransaksiApp(IdTransaksi: 1);
      //   },
      // ),
      GoRoute(
          path: AllCoaApp.routeName,
          name: AllCoaApp.routeName,
          builder: (context, state) => AllCoaApp()),
      GoRoute(
          path: Beranda.routeName,
          name: Beranda.routeName,
          builder: (context, state) => Beranda()),
      GoRoute(
        path: Transaksi2App.routeName,
        name: Transaksi2App.routeName,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => sl<TransaksiCubit>(),
            child: Transaksi2App(),
          );
          // return Transaksi2App();
        },
      ),
      GoRoute(
        path: RegisApp.routeName,
        name: RegisApp.routeName,
        builder: (context, state) {
          // return BlocProvider(
          //   create: (_) => sl<RegisterCubit>(),
          //   child: const RegisApp(),
          // );
          return const RegisApp();
        },
      ),
      // GoRoute(
      //   path: LoginPage.routeName,
      //   name: LoginPage.routeName,
      //   builder: (context, state) => const LoginPage(),
      // )
    ],
    // routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    initialLocation: LoginApp.routeName,
    // refreshListenable: GoRouterRefreshStream(context.read<AuthCubit>().stream),
    // redirect: (context, state) {
    //   final bool isAuthenticated =
    //       BoxMixin().getData(KeyStorage.accessToken) != null;
    //   final bool isOnOnboardingPage =
    //       state.matchedLocation == Transaksi2App.routeName ||
    //           state.matchedLocation == RegisApp.routeName ||
    //           state.matchedLocation == LoginApp.routeName;
    //   // return LoginApp.routeName;
    //   // return Transaksi2App.routeName;
    //   // return AllTxApp.routeName;
    //   // return EditTransaksiApp.routeName;
    //   return Transaksi2App.routeName;
    //   // return LoginApp.routeName;

    //   print("isAuthenticated");
    //   print(isAuthenticated);
    //   print("state.matchedLocation");
    //   print(state.matchedLocation);
    //   print("navigatorKey");
    //   print(navigatorKey.currentState);
    //   if (isAuthenticated) {
    //     if (isOnOnboardingPage) {
    //       return Transaksi2App.routeName;
    //     } else {
    //       return Transaksi2App.routeName;
    //     }
    //   } else {
    //     if (!isOnOnboardingPage) {
    //       return LoginApp.routeName;
    //     }
    //   }
    //   return null;
    // },
  );
}
