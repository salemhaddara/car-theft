// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:cartheftsafety/core/theme/Widgets/MyNavigationBar.dart';
import 'package:cartheftsafety/core/theme/Widgets/inputfield.dart';
import 'package:cartheftsafety/core/theme/Widgets/signuprichtext.dart';
import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final formKey = GlobalKey<FormState>();
  String emailcheck = '', passwordcheck = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark));
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
                      child: _donthaveaccount(size),
                    ),
                  )),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: size.height / 2,
                  margin: const EdgeInsets.all(6),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(50, 255, 255, 255),
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      )),
                  child: Column(
                    children: [
                      _SignInTitle(size),
                      _form(size, context),
                      _signinButton(size, context),
                    ],
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
        text: 'UserName',
        color: white,
        fontsize: size.height * 0.017,
        align: TextAlign.start,
      ),
    );
  }

  Widget _emailField(Size size, BuildContext blocContext) {
    return SizedBox(
      height: 54,
      child: InputField(
        hint: '',
        isPassword: false,
        icon: Icons.person,
        validator: (email) {
          if (email!.isEmpty) {
            return null;
          }
          if (email.isNotEmpty && email.length < 3) {
            return 'UserName Must be more than 3 characters';
          }

          return null;
        },
        initialState: false,
        onChanged: (text) {
          // emailcheck = text!;
        },
      ),
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
        passwordcheck = text!;
      },
    );
  }

  _signinButton(Size size, BuildContext pagecontext) {
    // bool Navigated = false;
    // bool isError = false;
    // return BlocBuilder<loginbloc, loginstate>(builder: (context, state) {
    //   if (state.formstatus is submissionsuccess && !Navigated) {
    //     WidgetsBinding.instance.addPostFrameCallback((_) {
    //       // Navigator.of(pagecontext).pushReplacementNamed(homescreenRoute);
    //     });
    //     Navigated = true;
    //     return Container();
    //   }
    //   if (state.formstatus is submissionfailed && !isError) {
    //     WidgetsBinding.instance.addPostFrameCallback((_) async {
    //       ScaffoldMessenger.of(pagecontext).showSnackBar(showSnackbar(
    //           (state.formstatus as submissionfailed).exception.toString(),
    //           size));
    //       context.read<loginbloc>().add(returnInitialStatus());
    //     });
    //     isError = true;
    //     return Container();
    //   }
    //   return state.formstatus is formsubmitting
    //       ? Container(
    //           margin: const EdgeInsets.only(top: 26),
    //           child: CircularProgressIndicator(
    //             color: white,
    //             strokeWidth: 6,
    //           ),
    //         )
    //       : Container(
    //           margin: const EdgeInsets.only(top: 26),
    //           child: GestureDetector(
    //             onTap: () {
    //               if (emailcheck.isNotEmpty && passwordcheck.isNotEmpty) {
    //                 if (formKey.currentState!.validate()) {
    //                   context
    //                       .read<loginbloc>()
    //                       .add((loginSubmitted(emailcheck, passwordcheck)));
    //                 }
    //               }
    //             },
    //             child:
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return MyNavigationBar(index: 0);
        }));
      },
      child: Container(
        height: size.height * 0.06,
        width: size.width / 1.5,
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(14),
            ),
            color: black),
        margin: const EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: text400normal(
          text: 'Sign In',
          fontsize: size.height * 0.02,
          color: white,
        ),
      ),
    );
    //           ),
    //         );
    // });
  }

  Widget _donthaveaccount(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: signuprichtext(
          startText: 'Dont Have An Account ?',
          clickableText: ' Sign Up',
          fontsize: size.height * 0.018,
          onClick: () {
            // Navigator.pushNamed(context, SignUpscreenRoute);
          }),
    );
  }
}
