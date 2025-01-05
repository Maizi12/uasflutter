import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uas_flutter/dependencies_injection.dart';
import 'package:uas_flutter/domain/bloc/auth/auth_bloc.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/view/login/cubit/auth_cubit.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:uas_flutter/route.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await dotenv.load(fileName: ".env");
  await serviceLocator();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    print(e.message.toString());
  }
  runApp(BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(userRepository: UserRepository())..add(AppStarted());
      },
      child: MyHomePage(title: 'Apk', userRepository: UserRepository())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(
        title: 'Apk',
        userRepository: UserRepository(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final UserRepository userRepository;
  const MyHomePage(
      {super.key, required this.title, required this.userRepository});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()),
      ],
      child: OKToast(
        child: ScreenUtilInit(
          designSize: const Size(375, 667),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, __) {
            Routing.setStream(context);
            return MaterialApp.router(
              routerConfig: Routing.router,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // colorScheme: ColorScheme.fromSeed(
                //   seedColor: Constants.get.primaryColor,
                // ),
                scaffoldBackgroundColor: Colors.white,
                useMaterial3: true,
                fontFamily: 'Poppins',
              ),
              builder: (BuildContext context, Widget? child) {
                final MediaQueryData data = MediaQuery.of(context);
                return MediaQuery(
                  data: data.copyWith(
                    alwaysUse24HourFormat: true,
                    textScaler: const TextScaler.linear(1),
                  ),
                  child: child!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
