import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_style.dart';
import 'home/home_page.dart';
import 'portofolio/portofolio_page.dart';
import 'profile/profile_page.dart';
import 'support/support_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static const nameRoute = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> pages = [
      HomePage(),
      PortofolioPage(),
      SupportPage(),
      ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: pages[_selectedIndex],
      bottomNavigationBar: _customBottomNav(),
    );
  }

  Widget _customBottomNav() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
          boxShadow: [BoxShadow(color: kGrey, blurRadius: 18)]),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: kCaption,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          unselectedLabelStyle: kCaption,
          selectedItemColor: kBlueRibbon,
          unselectedItemColor: kDarkGray,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home.png',
                width: 20,
                color: _selectedIndex == 0 ? kBlueRibbon : kDarkGray,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/portofolio.png',
                  width: 20,
                  color: _selectedIndex == 1 ? kBlueRibbon : kDarkGray,
                ),
                label: 'Portofolio'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/support.png',
                  width: 20,
                  color: _selectedIndex == 2 ? kBlueRibbon : kDarkGray,
                ),
                label: 'Support'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/profile.png',
                  width: 20,
                  color: _selectedIndex == 3 ? kBlueRibbon : kDarkGray,
                ),
                label: 'Profile'),
          ]),
    );
  }
}
