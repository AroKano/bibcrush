import 'package:flutter/material.dart';

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
      color: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.home, 0),
              buildNavItem(Icons.search, 1),
              buildNavItem(Icons.add_box, 2),
              buildNavItem(Icons.inbox, 3),
              buildNavItem(Icons.person_rounded, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        onTabChange(index);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selectedIndex == index ? Color(0xFFFF7A00) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Icon(
          icon,
          color: selectedIndex == index ? Color(0xFFFF7A00) : Colors.black,
        ),
      ),
    );
  }
}