import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:uas_flutter/regis.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/splash-2.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    print(e.message.toString());
  }
  runApp(const MyApp());
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
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('${bloc.runtimeType} $stackTrace');
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        // 425x868
        body: Container(
            color: Colors.cyan,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: ElevatedButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: const Text("<<< Exit")),
                  )
                ],
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 500,
                      height: 100,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Institut Teknologi Tangerang Selatan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF005A92),
                                fontSize: 20,
                                fontFamily: 'SF Pro Rounded',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            )
                          ])),
                  SizedBox(
                      width: 500,
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(image: AssetImage('assets/splash1.png'))
                        ],
                      )),
                  SizedBox(
                    width: 343,
                    height: 200,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 100,
                  ),
                  Container(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisApp()));
                        },
                        child: const Text("Next >>>")),
                  )
                ],
              )
            ])));
  }
}
