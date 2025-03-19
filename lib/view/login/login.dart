import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
// import 'dart:js';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
// import 'package:uas_flutter/domain/bloc/auth/auth_bloc.dart';
import 'package:uas_flutter/view/login/cubit/auth_cubit.dart';
import 'package:uas_flutter/view/regis/regis.dart';

import '../transaksi/transaksi2.dart';

class SignInSignUpResult {
  final String message;
  SignInSignUpResult({required this.message});
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key, this.isSelected});
  static const routeName = '/login_page';

  final bool? isSelected;
  @override
  State<LoginApp> createState() => LoginClass();
}

class LoginClass extends State<LoginApp> {
  String? error;
  bool isSelectedpassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            failed: (String? e) {
              setState(() {
                error = e;
              });
            },
          );
        },
        child: Scaffold(
          body: SingleChildScrollView(
            // width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  // frame20465m7i (117:3575)
                  // margin: const EdgeInsets.fromLTRB(20, 0, 20, 308),
                  width: 335,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 1.2125,
                              color: Color(0xff240e50),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 68,
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 0, 17, 253),
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                24)),
                                                  ),
                                                  child: TextField(
                                                    controller: emailController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0),
                                                      labelText:
                                                          'Username(Email)',
                                                    ),
                                                  ),
                                                )

                                                // const SizedBox(height: 8),
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    // input6je (117:3593)
                                    width: double.infinity,
                                    height: 61,
                                    child: GestureDetector(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 0, 17, 253),
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(24)),
                                            ),
                                            child: TextFormField(
                                              controller: passwordController,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 0, 0),
                                                  labelText: 'Password',
                                                  suffixIcon: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          isSelectedpassword =
                                                              !isSelectedpassword;
                                                          passwordController
                                                                  .value =
                                                              passwordController
                                                                  .value;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        isSelectedpassword
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                      ))),
                                              obscureText: isSelectedpassword,
                                            ),
                                          )
                                        ])),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 1, 0),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2125,
                                  color: Color(0xff2c14dd),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 308,
                ),
                Container(
                  // button7At (117:3605)
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // buttonlarge3KS (117:3606)
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xff2c14dd),
                          borderRadius: BorderRadius.circular(100),
                        ),

                        child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              cubit.GetKey();
                              cubit.login(
                                  // userName: emailController.text,
                                  userName: "test@gmail.com",
                                  // password: passwordController.text);
                                  password: "123456");
                              // final storage.FlutterSecureStorage storages =
                              //     storage.FlutterSecureStorage();
                              // var token = await storages.read(key: 'token');

                              // // TODO:Kondisi ketika token expire langsung ke relog
                              // // print(await storages.read(key: 'token'));
                              // if (token != null) {
                              //   print("token $token");
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               // WelcomeApp()
                              //               Transaksi2App()));
                              //   // showDialog(
                              //   //   context: context,
                              //   //   builder: (BuildContext context) {
                              //   //     return AlertDialog(
                              //   //         title: const Text("Error"),
                              //   //         content: Text("tokennya$token"),
                              //   //         actions: <Widget>[
                              //   //           TextButton(
                              //   //             onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          // WelcomeApp()
                                          Transaksi2App()));
                              //   //             },
                              //   //             child: const Text("OK"),
                              //   //           )
                              //   //         ]);
                              //   //   },
                              //   // );
                              // } else {
                              //   final bloc =
                              //       BlocProvider.of<EnkripBloc>(context);
                              //   bloc.add(Login(
                              //     email: "test@gmail.com",
                              //     password: "123456",
                              //     // email: emailController.text,
                              //     // password: passwordController.text,
                              //   ));
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               // WelcomeApp()
                              //               Transaksi2App()));
                              // }
                            },
                            child: const Center(
                              child: Text(
                                'Login',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.26,
                                  color: Color(0xfffbfbfb),
                                ),
                              ),
                            )),
                      ),
                      Container(
                        // buttonlargehPz (117:3608)
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),

                        child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const RegisApp()));
                            },
                            child: const Center(
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.26,
                                  color: Color(0xff2c14dd),
                                ),
                              ),
                            )),
                      ),
                      Container(
                        child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Text("Delete token"),
                            onTap: () async {
                              final storage.FlutterSecureStorage storages =
                                  storage.FlutterSecureStorage();
                              await storages.delete(key: 'token');
                              print("delete token");
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange.shade900,
      content: Text(message.toString())));
}
