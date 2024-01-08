// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';

import 'package:cartheftsafety/config/utils.dart';
import 'package:cartheftsafety/core/theme/Widgets/inputfield.dart';
import 'package:cartheftsafety/core/theme/Widgets/mySnackbar.dart';
import 'package:cartheftsafety/core/theme/Widgets/signuprichtext.dart';
import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:cartheftsafety/core/theme/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  String emailcheck = '',
      passwordcheck = '',
      fullNameCheck = '',
      deviceIdCheck = '';
  void _createAccount() async {
    try {
      if (formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        QuerySnapshot querySnapshot = await _firestore
            .collection('devices')
            .where('id', isEqualTo: deviceIdCheck)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          UserCredential userCredential =
              await _auth.createUserWithEmailAndPassword(
            email: emailcheck,
            password: passwordcheck,
          );

          if (userCredential.user != null) {
            await _firestore
                .collection('users')
                .doc(userCredential.user!.uid)
                .set({
              'fullName': fullNameCheck,
              'email': emailcheck,
              'deviceId': deviceIdCheck,
            });
            setState(() {
              isLoading = false;
            });
            mySnackbar.showSnackbar(
                context, 'Your Account is successfuly Created');

            Navigator.pushNamed(context, '');
          }
        } else {
          // Device ID doesn't exist in 'devices' collection
          mySnackbar.showSnackbar(context, 'Device ID does not exist.');
          setState(() {
            isLoading = false;
          });
        }
      }
    } on SocketException {
      mySnackbar.showSnackbar(context, 'Check Your Internet Connection');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      mySnackbar.showSnackbar(context, 'Unknown Server Error, Try Again Later');
      setState(() {
        isLoading = false;
      });
    }
  }

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
                  height: size.height / 2,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/car.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: _haveaccount(size),
                    ),
                  )),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: size.height / 1.2,
                  margin: const EdgeInsets.all(6),
                  padding: const EdgeInsets.all(16),
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
                        _SignUpTitle(size),
                        _form(size, context),
                        IgnorePointer(
                          ignoring: isLoading,
                          child: Opacity(
                            opacity: isLoading ? 0.5 : 1.0,
                            child: _signUpButton(size, context),
                          ),
                        ),
                        if (isLoading)
                          Container(
                            alignment: Alignment.topCenter,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(white),
                            ),
                          ),
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
          _fullNameTitle(size),
          _fullNameField(size, blocContext),
          _emailTitle(size),
          _emailField(size, blocContext),
          _deviceIdTitle(size),
          _deviceIdField(size, blocContext),
          _passwordTitle(size),
          _passwordField(size, blocContext),
        ],
      ),
    );
  }

  Widget _SignUpTitle(Size size) {
    return Container(
        width: size.width,
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        child: text400normal(
          text: 'Create An Account',
          fontsize: size.height * 0.030,
          weight: FontWeight.w400,
          color: white,
        ));
  }

  Widget _fullNameTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 26, bottom: 10),
      constraints: const BoxConstraints(maxWidth: 600),
      child: text400normal(
        text: 'full Name',
        color: white,
        fontsize: size.height * 0.017,
        align: TextAlign.start,
      ),
    );
  }

  Widget _fullNameField(Size size, BuildContext blocContext) {
    return InputField(
      hint: '',
      isPassword: false,
      icon: Icons.person,
      validator: (email) {
        if (email!.isEmpty) {
          return null;
        }
        if (email.isNotEmpty && email.length < 3) {
          return 'Full Name Must be more than 3 characters';
        }

        return null;
      },
      initialState: false,
      onChanged: (text) {
        fullNameCheck = '$text';
      },
    );
  }

  _emailTitle(Size size) {
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

  _emailField(Size size, BuildContext blocContext) {
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

  Widget _deviceIdTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 26, bottom: 10),
      constraints: const BoxConstraints(maxWidth: 600),
      child: text400normal(
        text: 'Device Id',
        color: white,
        fontsize: size.height * 0.017,
        align: TextAlign.start,
      ),
    );
  }

  Widget _deviceIdField(Size size, BuildContext blocContext) {
    return InputField(
      hint: '',
      isPassword: false,
      icon: Icons.device_hub,
      validator: (email) {
        if (email!.isEmpty) {
          return null;
        }

        return null;
      },
      initialState: false,
      onChanged: (text) {
        deviceIdCheck = '$text';
      },
    );
  }

  _passwordTitle(Size size) {
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

  _signUpButton(Size size, BuildContext pagecontext) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: InkWell(
        onTap: () {
          //make the sign In Logic Here
          if (formKey.currentState!.validate() &&
              emailcheck.isNotEmpty &&
              passwordcheck.isNotEmpty &&
              deviceIdCheck.isNotEmpty) {
            _createAccount();
          }
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
              color: black),
          alignment: Alignment.center,
          child: text400normal(
            text: 'Create Account',
            fontsize: size.height * 0.02,
            color: white,
          ),
        ),
      ),
    );
  }

  Widget _haveaccount(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: signuprichtext(
          startText: 'Have An Account ?',
          clickableText: ' Sign In',
          fontsize: size.height * 0.018,
          onClick: () {
            Navigator.pushNamed(context, loginRoute);
          }),
    );
  }
}
