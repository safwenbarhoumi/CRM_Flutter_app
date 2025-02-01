import 'package:flutter/material.dart';
import 'bottomNavigationBar.dart';
import 'chat_screen.dart';
import 'dashboard_screen.dart';
import 'demandes_screen.dart';
import 'profil_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  // Liste des écrans correspondant aux onglets
  final List<Widget> _screens = [
    const DashboardScreen(),
    const DemandesScreen(),
    const ChatScreen(),
    const ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Afficher l'écran sélectionné
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex, // Correction ici
        onItemTapped: (index) {
          // Correction ici
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
