// import 'dart:js';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_flutter/models/login.dart';
import 'package:uas_flutter/models/response.dart';
import 'package:uas_flutter/regis.dart';
import 'package:uas_flutter/welcome.dart';

class SignInSignUpResult {
  // final User user;
  final String message;
  // SignInSignUpResult({required this.user, required this.message});
  SignInSignUpResult({required this.message});
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key, this.isSelected});

  final bool? isSelected;
  @override
  State<LoginApp> createState() => LoginClass();
}

class LoginClass extends State<LoginApp> {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

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

  bool isSelectedpassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // frame20465m7i (117:3575)
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 308),
              width: 335,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 100, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          // titleQRa (117:3577)
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: const Text(
                            'Login',
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
                          'Login to get started',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.5714285714,
                            color: Color(0xff292b2d),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // frame20464c1r (117:3579)
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // frame20463kNx (117:3580)
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // baseGcC (117:3588)
                                // margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                // padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                                width: double.infinity,
                                height: 66,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: SizedBox(
                                  // autogroupxaoe9fz (Gyg1jiTWFt65XTUjD3xaoE)
                                  // width: 118,
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // labelt7n (117:3592)
                                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              TextField(
                                                controller: emailController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Username(Email)',
                                                ),
                                              ),
                                            ]),
                                      ),
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
                                      TextFormField(
                                        controller: passwordController,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            labelText: 'Password',
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isSelectedpassword =
                                                        !isSelectedpassword;
                                                    passwordController.value =
                                                        passwordController
                                                            .value;
                                                  });
                                                },
                                                icon: Icon(
                                                  isSelectedpassword
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                ))),
                                        obscureText: isSelectedpassword,
                                      ),
                                    ])),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // forgotpasswordbiL (117:3616)
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
            Container(
              // button7At (117:3605)
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 37),
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
                        onTap: () async {
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeApp()));
                          } else {
                            SignInSignUpResult result = await signInWithEmail(
                                email: emailController.text,
                                pass: passwordController.text);
                            if (result.message == "Sukses") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeApp()));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Error"),
                                        content: Text(result.message),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("OK"),
                                          )
                                        ],
                                      ));
                            }
                          }
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
                  )
                ],
              ),
            ),
            FutureBuilder<String>(
              future: fetchFromServer(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}",
                        style: const TextStyle(color: Colors.redAccent)),
                  );
                }
                if (snapshot.hasData) {
                  return Container(
                      child: Text("Dinamis Cuy $snapshot.data.toString()"));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> fetchFromServer() async {
    String credentials =
        "RqKYq1xXH8SXyLnHdd5ra1cgO7fzz1uK:06jIai4azaoM3nmPedAwIC5LJiDbbkU6";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);
    // return base64.StdEncoding.EncodeToString([]byte(auth))
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "api-key": "ufr46B5waDi8dU0EgLuidOkJCrUkZQHY",
      "Authorization": "Basic $encoded",
      "timestamps": "abc",
      "xkey": "abc",
    };
    var response = await http.get(
        Uri.http("192.168.137.64:80", "/v1/user/enkrip"),
        headers: requestHeaders);
    Token productList;
    String result = "";
    print(response.body);
    print(response.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responses = convert.jsonDecode(response.body);
      var respon = ResponseJSON.fromJson(responses);
      print(respon.code);
      var productMap = respon.data;
      productList = Token.fromJson(productMap);
      result = productList.key;
    }
    return result;
  }
}

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange.shade900,
      content: Text(message.toString())));
}
