import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_flutter/dependencies_injection.dart';
import 'package:uas_flutter/domain/services/hive/hive.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';
import 'package:uas_flutter/view/transaksi/transaksi2.dart';
import 'package:uas_flutter/view/beranda/beranda.dart';
import 'package:uas_flutter/view/login/login.dart';
import 'package:uas_flutter/view/regis/regis.dart';

class Routing {
  static late BuildContext context;
  Routing.setStream(BuildContext ctx) {
    context = ctx;
  }

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: LoginApp.routeName,
        name: LoginApp.routeName,
        builder: (_, __) {
          return const LoginApp();
        },
      ),
      GoRoute(
        path: Beranda.routeName,
        name: Beranda.routeName,
        builder: (_, __) {
          // return BlocProvider(
          //   create: (_) => sl<BerandaCubit>(),
          //   child: const Beranda(),
          // );
          return const Beranda();
        },
      ),
      GoRoute(
        path: Transaksi2App.routeName,
        name: Transaksi2App.routeName,
        builder: (_, __) {
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
        builder: (_, __) {
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
      //   builder: (_, __) => const LoginPage(),
      // )
    ],
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    // refreshListenable: GoRouterRefreshStream(context.read<AuthCubit>().stream),
    redirect: (context, state) {
      final bool isAuthenticated =
          BoxMixin().getData(KeyStorage.accessToken) != null;
      final bool isOnOnboardingPage =
          state.matchedLocation == Transaksi2App.routeName ||
              state.matchedLocation == RegisApp.routeName ||
              state.matchedLocation == LoginApp.routeName;
      // return LoginApp.routeName;
      print("isAuthenticated");
      print(isAuthenticated);
      print("state.matchedLocation");
      print(state.matchedLocation);
      if (isAuthenticated) {
        if (isOnOnboardingPage) {
          return Transaksi2App.routeName;
        } else {
          return Transaksi2App.routeName;
        }
      } else {
        if (!isOnOnboardingPage) {
          return LoginApp.routeName;
        }
      }
      return null;
    },
  );
}
