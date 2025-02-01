import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.015,
        horizontal: screenWidth * 0.05,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) => _buildNavItem(context, index)),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    List<IconData> icons = [
      Icons.dashboard,
      Icons.assignment,
      Icons.chat,
      Icons.person
    ];
    List<String> labels = ["Dashboard", "Demandes", "Chat", "Profil"];
    List<Color> colors = [
      Colors.blueAccent,
      Colors.green,
      Colors.orange,
      Colors.purple
    ];

    bool isSelected = selectedIndex == index;
    double iconSize = MediaQuery.of(context).size.width * 0.07;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.015,
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? colors[index].withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icons[index],
              color: isSelected ? colors[index] : Colors.grey,
              size: isSelected ? iconSize * 1.2 : iconSize,
            ),
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02),
                child: Text(
                  labels[index],
                  style: GoogleFonts.lato(
                    color: colors[index],
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
