// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_flutter/beranda.dart';

class SignInSignUpResult {
  // final User user;
  final String message;
  // SignInSignUpResult({required this.user, required this.message});
  SignInSignUpResult({required this.message});
}

class Login extends StatelessWidget {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signInWithEmail(
      {required String email, required String pass}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return SignInSignUpResult(message: 'Sukses');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return SignInSignUpResult(message: "Password atau email salah");
      } else if (e.code == 'channel-error') {
        return SignInSignUpResult(
            message: "Pastikan email dan password terisi");
      } else if (e.code == 'invalid-email') {
        return SignInSignUpResult(message: "Email harus diisi dengan benar");
      }
      print("e.code:$e.code");
      return SignInSignUpResult(message: e.toString());
    }
  }

  static void signOut() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sistem Akademik Mahasiswa'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
                width: 500,
                height: 51,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username(Email)',
                        ),
                      ),
                    ])),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 500,
              height: 51,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    )
                  ]),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              child: ElevatedButton(
                  onPressed: () async {
                    SignInSignUpResult result = await signInWithEmail(
                        email: emailController.text,
                        pass: passwordController.text);
                    if (result.message == 'Sukses') {
                      print("result.message:$result.message");
                      // Go to Profile Page
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Beranda()));
                    } else {
                      // Show Dialog
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Error"),
                                content: Text(result.message),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  )
                                ],
                              ));
                    }
                  },
                  child: StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.userChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return const Text('Logout');
                        } else {
                          return const Text('LogIn');
                        }
                      })),
            )
          ],
        ));
  }
}

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange.shade900,
      content: Text(message.toString())));
}
