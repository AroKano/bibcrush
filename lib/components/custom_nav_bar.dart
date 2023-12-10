import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavBar extends StatelessWidget {
  final Function(int) onTabChange;
  final int? selectedIndex; // Make selectedIndex optional

  const CustomNavBar({
    Key? key,
    required this.onTabChange,
    this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.3)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Colors.black,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                iconColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
                iconColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              GButton(
                icon: Icons.add_box,
                text: 'Post',
                iconColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              GButton(
                icon: Icons.inbox,
                text: 'Inbox',
                iconColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
                iconColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.black,
              ),
            ],
            selectedIndex: selectedIndex ?? 0, // Default to 0 if selectedIndex is null
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}
