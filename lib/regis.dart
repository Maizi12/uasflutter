import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:uas_flutter/domain/bloc/auth/auth_bloc.dart';
import 'package:uas_flutter/domain/bloc/enkrip/enkrip_bloc.dart';
import 'package:uas_flutter/login.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';

import 'models/user.dart';
import 'transaksi.dart';

class SignUpResult {
  // final User user;
  final String message;
  // SignUpResult({required this.user, required this.message});
  SignUpResult({required this.message});
}

class RegisApp extends StatefulWidget {
  const RegisApp({super.key, this.isSelected});

  final bool? isSelected;
  @override
  State<RegisApp> createState() => RegisClass();
}

class RegisClass extends State<RegisApp> {
  var userid = Userid(0);
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<SignUpResult> signUpWithEmail(
      {required String email, required String pass}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      return SignUpResult(message: 'Sukses');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return SignUpResult(message: "Password atau email salah");
      } else if (e.code == 'channel-error') {
        return SignUpResult(message: "Pastikan email dan password terisi");
      } else if (e.code == 'invalid-email') {
        return SignUpResult(message: "Email harus diisi dengan benar");
      } else if (e.code == 'weak-password') {
        return SignUpResult(
            message: "Password harus berisi minimal 6 karakter");
      } else if (e.code == 'email-already-in-use') {
        return SignUpResult(message: "Email sudah terdaftar");
      }
      print("e.code:$e.code");
      return SignUpResult(message: e.toString());
    }
  }

  late Future<ResponseEnkrip> getKey;
  @override
  bool isSelected = false;
  bool isSelectedpassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final bloc = context;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection('user');
    var curruser = Users;
    return BlocProvider(
        create: (context) {
          //  authBloc: BlocProvider.of<AuthBloc>(context)
          return EnkripBloc(BlocProvider.of<AuthBloc>(context));
        },
        child: BlocListener<EnkripBloc, EnkripState>(
            listener: (context, state) {},
            child:
                BlocBuilder<EnkripBloc, EnkripState>(builder: (context, state) {
              return Scaffold(
                  body: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: Container(
                          child: Column(children: [
                        Container(
                          width: 335,
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 68, 15),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2125,
                                    color: Color(0xff240e50),
                                  ),
                                ),
                              ),
                              const Text(
                                'Complete the sign up to get started',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5714285714,
                                  color: Color(0xff292b2d),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 32),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 12, 0, 6),
                                            // width: double.infinity,
                                            height: 77,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffffffff),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            child: SizedBox(
                                                height: double.infinity,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      TextField(
                                                        controller:
                                                            emailController,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Username(Email)',
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 12, 0, 6),
                                            // width: double.infinity,
                                            height: 77,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffffffff),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            child: GestureDetector(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                  TextFormField(
                                                    controller:
                                                        passwordController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: InputDecoration(
                                                        border:
                                                            const OutlineInputBorder(),
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
                                                                  ? Icons
                                                                      .visibility
                                                                  : Icons
                                                                      .visibility_off,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark,
                                                            ))),
                                                    obscureText:
                                                        isSelectedpassword,
                                                  ),
                                                ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          setState(() {
                                            isSelected = !isSelected;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CheckboxWidget(
                                                isSelected: isSelected),
                                            const SizedBox(width: 16),
                                            const Flexible(
                                              child: Text(
                                                  'By signing up, you agree to the Terms of Service and Privacy Policy'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 196, 0, 37),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // buttonlargefV6 (117:3541)
                                margin:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 12),
                                width: 343,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xff2c14dd),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Center(
                                    child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () async {
                                          SignUpResult result =
                                              await signUpWithEmail(
                                                  email: emailController.text,
                                                  pass:
                                                      passwordController.text);
                                          List<String> namauser =
                                              emailController.text.split('@');
                                          print(namauser[0]);
                                          if (result.message == "Sukses") {
                                            _auth.signOut();
                                            user.add({
                                              'email': emailController.text,
                                              'idUser': FieldValue.increment(1),
                                              'isPasscodeActive': 0,
                                              'passcode': 0,
                                              'namaUser': namauser[0],
                                            }).then(
                                                (value) => showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: const Text(
                                                              "Success"),
                                                          content: const Text(
                                                              "DocumentSnapshot successfully updated!"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                TransaksiApp()));
                                                              },
                                                              child: const Text(
                                                                  "OK"),
                                                            )
                                                          ],
                                                        )),
                                                onError: (e) => showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: const Text(
                                                              "Error"),
                                                          content: Text(
                                                              "Error updating document $e"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "OK"),
                                                            )
                                                          ],
                                                        )));
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginApp()));
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title:
                                                          const Text("Error"),
                                                      content:
                                                          Text(result.message),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("OK"),
                                                        )
                                                      ],
                                                    ));
                                          }
                                        },
                                        child: const Text(
                                          'Sign Up',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 1.26,
                                            color: Color(0xfffbfbfb),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              Container(
                                  width: 343,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginApp()));
                                    },
                                    child: const Text(
                                      'Login ',
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
                            ],
                          ),
                        )
                      ]))));
            })));
  }
}

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange.shade900,
      content: Text(message.toString())));
}

class CheckboxWidget extends StatelessWidget {
  final bool isSelected;
  const CheckboxWidget({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isSelected == true ? const Color(0xff2C14DD) : Colors.white,
        border: Border.all(width: 1, color: const Color(0xff2C14DD)),
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            )
          : const SizedBox.shrink(),
    );
  }
}
