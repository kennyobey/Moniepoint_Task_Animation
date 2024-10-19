import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:moniepoint_test/screens/home.dart';

import '../utils/app_colors.dart';
import 'map_page.dart';

class BottmNavBar extends StatefulWidget {
  const BottmNavBar({super.key});

  @override
  State<BottmNavBar> createState() => _BottmNavBarState();
}

class _BottmNavBarState extends State<BottmNavBar> {
  int _selectedIndex = 2;
  static const List<Widget> _pages = <Widget>[
    MapPage(),
    Center(child: Text('Search Page')),
    SamplePage(),
    Center(child: Text('Favorites Page')),
    Center(child: Text('Profile Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 60,
        ),
        height: 80, // Adjust height if needed

        child: SlideInUp(
          curve: Curves.linear,
          from: 680,
          duration: const Duration(seconds: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.darkGrey,
              unselectedItemColor: AppColors.white,
              selectedItemColor: AppColors.orange,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: List.generate(5, (index) {
                return BottomNavigationBarItem(
                  icon: _selectedIndex == index
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          decoration: const BoxDecoration(
                            color: AppColors
                                .orange, // Black container for selected icon
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getIconForIndex(index),
                            color: Colors.white,
                            size: 18,
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(13),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightBlack),
                          child: Icon(
                            _getIconForIndex(index),
                            color: AppColors.white,
                            size: 18,
                          ),
                        ),
                  label: '',
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to get the icons
  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.search;
      case 1:
        return Icons.chat;
      case 2:
        return Icons.home_filled;
      case 3:
        return Icons.favorite;
      case 4:
        return Icons.person;
      default:
        return Icons.home;
    }
  }
}
