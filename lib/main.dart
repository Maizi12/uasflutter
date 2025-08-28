import 'package:digit/appTheme.dart';
import 'package:digit/dependencies_injection.dart';
import 'package:digit/presentation/cubits/auth/auth_cubit.dart';
import 'package:digit/providers/navigation_history_provider.dart';
import 'package:digit/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await Hive.initFlutter(); // ✅ Keep - data storage
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Keep - required
  await initializeDateFormatting('id_ID', null); // ✅ Keep - localization
  await dotenv.load(fileName: ".env"); // ✅ Keep - environment config
  await serviceLocator(); // ✅ Keep - dependency injection
  runApp(MyApp()); // ✅ Simplified
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AuthCubit>()),
          // Add other global providers here
        ],
        child: ChangeNotifierProvider(
          // ✅ WRAP WITH ChangeNotifierProvider
          create: (_) => sl<NavigationHistory>(),
          child: OKToast(
            child: ScreenUtilInit(
              designSize: const Size(375, 812), // Update to modern screen ratio
              builder: (context, __) {
                return MaterialApp.router(
                  routerConfig: AppRouter.router, // Your routing logic
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme(), // Extract to separate file
                );
              },
            ),
          ),
        ));
  }
}
