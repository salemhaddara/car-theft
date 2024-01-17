// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';

import 'package:cartheftsafety/config/utils.dart';
import 'package:cartheftsafety/core/theme/Widgets/MyNavigationBar.dart';
import 'package:cartheftsafety/core/theme/Widgets/inputfield.dart';
import 'package:cartheftsafety/core/theme/Widgets/mySnackbar.dart';
import 'package:cartheftsafety/core/theme/Widgets/signuprichtext.dart';
import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:cartheftsafety/core/theme/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final formKey = GlobalKey<FormState>();
  String emailcheck = '', passwordcheck = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: black,
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: size.height,
                  width: size.width,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(0),
                  child: Image.asset(
                    'assets/images/car.jpg',
                    height: size.height,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: _donthaveaccount(size),
                    ),
                  )),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: size.height / 2,
                  margin: const EdgeInsets.all(6),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(50, 255, 255, 255),
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      )),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _SignInTitle(size),
                        _form(size, context),
                        _signinButton(size, context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _form(Size size, blocContext) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _emailTitle(size),
          _emailField(size, blocContext),
          _passwordTitle(size),
          _passwordField(size, blocContext),
        ],
      ),
    );
  }

  Widget _SignInTitle(Size size) {
    return Container(
        width: size.width,
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        child: text400normal(
          text: 'Welcome Back !',
          fontsize: size.height * 0.030,
          weight: FontWeight.w400,
          color: white,
        ));
  }

  Widget _emailTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 26, bottom: 10),
      constraints: const BoxConstraints(maxWidth: 600),
      child: text400normal(
        text: 'Email Address',
        color: white,
        fontsize: size.height * 0.017,
        align: TextAlign.start,
      ),
    );
  }

  Widget _emailField(Size size, BuildContext blocContext) {
    return InputField(
      hint: '',
      isPassword: false,
      icon: Icons.person,
      validator: (email) {
        if (email!.isEmpty) {
          return null;
        }
        if (email.isNotEmpty && !utils.isValidEmail(email)) {
          return 'Enter A Valid email address';
        }

        return null;
      },
      initialState: false,
      onChanged: (text) {
        emailcheck = '$text';
      },
    );
  }

  Widget _passwordTitle(Size size) {
    return Container(
      width: size.width,
      constraints: const BoxConstraints(maxWidth: 600),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: 'Password',
        color: white,
        fontsize: size.height * 0.017,
      ),
    );
  }

  Widget _passwordField(Size size, BuildContext blocContext) {
    return InputField(
      hint: '',
      isPassword: true,
      icon: Icons.password_outlined,
      validator: (password) {
        if (password == null || password.isEmpty) {
          return null;
        }
        if (password.length < 8) {
          return 'Please Enter A Valid Password';
        }
        return null;
      },
      initialState: true,
      onChanged: (text) {
        passwordcheck = '$text';
      },
    );
  }

  _signinButton(Size size, BuildContext pagecontext) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: InkWell(
        onTap: isLoading
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                });
                if (formKey.currentState!.validate() &&
                    emailcheck.isNotEmpty &&
                    passwordcheck.isNotEmpty) {
                  await signInUser();
                } else {
                  mySnackbar.showSnackbar(
                      context, 'Enter Required Credentiels');
                }
                setState(() {
                  isLoading = false;
                });
              },
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        child: Container(
          height: size.height * 0.06,
          width: size.width / 1.5,
          constraints: const BoxConstraints(maxWidth: 600),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(14),
            ),
            color: black,
          ),
          alignment: Alignment.center,
          child: isLoading
              ? CircularProgressIndicator(
                  color: white,
                  strokeWidth: 2,
                )
              : text400normal(
                  text: 'Sign In',
                  fontsize: size.height * 0.02,
                  color: white,
                ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcheck, password: passwordcheck);

      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;

        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userData.exists) {
          Map<String, dynamic> user = userData.data() as Map<String, dynamic>;

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'fcm': ModalRoute.of(context)!.settings.arguments as String
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('email', emailcheck);
          await prefs.setString('fullName', user['fullName']);
          await prefs.setString('deviceId', user['deviceId']);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyNavigationBar(index: 0),
            ),
          );
        } else {
          mySnackbar.showSnackbar(context, 'User data not found.');
        }
      }
    } on SocketException {
      mySnackbar.showSnackbar(context, 'Check Your Internet Connection');
    } catch (e) {
      mySnackbar.showSnackbar(context, 'User Credentiels are not correct');
    }
  }

  Widget _donthaveaccount(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: signuprichtext(
          startText: 'Dont Have An Account ?',
          clickableText: ' Sign Up',
          fontsize: size.height * 0.018,
          onClick: () {
            Navigator.pushNamed(
              context,
              signUpRoute,
            );
          }),
    );
  }
}
