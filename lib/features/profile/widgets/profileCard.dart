// ignore_for_file: must_be_immutable, camel_case_types, file_names, use_build_context_synchronously

import 'package:cartheftsafety/core/theme/Widgets/logoutContainer.dart';
import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:cartheftsafety/features/welcome/welcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profileCard extends StatelessWidget {
  String username, emailAddress, phoneNumber, password;
  Size size;
  profileCard(
      {super.key,
      required this.username,
      required this.emailAddress,
      required this.phoneNumber,
      required this.password,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            elevation: 4,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            color: blue,
            child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _profilePhotoRow(),
                    _personalDetailsTitle(),
                    const Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                    _title('Email'),
                    _value(emailAddress),
                    _title('Device Id '),
                    _value(phoneNumber),
                    _title('Password'),
                    _value('**************'),
                  ],
                )),
          ),
          logoutContainer(
            size: size,
            onTap: () async {
              FirebaseAuth auth = FirebaseAuth.instance;
              await auth.signOut();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const welcomeScreen(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          )
        ],
      ),
    );
  }

  _value(String text) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      child: text400normal(
        color: black,
        fontsize: 16,
        text: text,
      ),
    );
  }

  _title(String text) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: text400normal(
        color: black,
        fontsize: 16,
        text: text,
      ),
    );
  }

  _personalDetailsTitle() {
    return const SizedBox(
      height: 40,
      child: Row(
        children: [
          text400normal(
              text: 'Personal Details', color: Colors.black, fontsize: 16),
          Spacer(),
        ],
      ),
    );
  }

  _profilePhotoRow() {
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 16),
        height: 80,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: 70,
                  padding: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: SvgPicture.asset('assets/images/usercircle.svg')),
            ),
            Expanded(
              flex: 3,
              child: text400normal(
                text: username,
                fontsize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ));
  }
}
