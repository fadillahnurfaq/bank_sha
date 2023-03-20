import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70.0,
      color: whiteColor,
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      notchMargin: 6,
      elevation: 0,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: whiteColor,
        elevation: 0,
        selectedItemColor: blueColor,
        unselectedItemColor: blackColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: blueTextStyle.copyWith(
          fontSize: 10,
          fontWeight: medium,
        ),
        unselectedLabelStyle: blackTextStyle.copyWith(
          fontSize: 10,
          fontWeight: medium,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_overview.png',
              width: 20,
              color: blueColor,
            ),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_history.png',
              width: 20,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_statistic.png',
              width: 20,
            ),
            label: 'Statistic',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_reward.png',
              width: 20,
            ),
            label: 'Reward',
          ),
        ],
      ),
    );
  }
}
