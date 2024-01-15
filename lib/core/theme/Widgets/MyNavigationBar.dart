import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:cartheftsafety/features/home/homeScreen.dart';
import 'package:cartheftsafety/features/locationsLog/locationsLog.dart';
import 'package:cartheftsafety/features/map/mapScreen.dart';
import 'package:cartheftsafety/features/profile/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// ignore: must_be_immutable
class MyNavigationBar extends StatefulWidget {
  int index;

  MyNavigationBar({super.key, required this.index});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  late PersistentTabController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: widget.index);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: const Color.fromARGB(255, 0, 0, 0),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }

  List<Widget> _buildScreens() {
    return [
      const homeScreen(),
      const mapScreen(),
      const LocationsLog(),
      const profileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/images/iconhome.svg'),
        title: 'Home',
        activeColorPrimary: white,
        inactiveColorPrimary: blue,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/images/carlocation.svg'),
        title: 'Location',
        activeColorPrimary: white,
        inactiveColorPrimary: blue,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/images/logswhite.svg'),
        title: 'Logs',
        activeColorPrimary: white,
        inactiveColorPrimary: blue,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/images/iconprofile.svg'),
        title: 'Profile',
        activeColorPrimary: white,
        inactiveColorPrimary: blue,
      ),
    ];
  }
}
