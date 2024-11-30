import 'package:flutter/material.dart';

import 'WalletPage.dart';
import 'HomePage.dart';
import 'FavoritePage.dart';

class NavigationBarApp extends StatefulWidget {
  @override
  _NavigationBarAppState createState() => _NavigationBarAppState();
}

class _NavigationBarAppState extends State<NavigationBarApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    WalletPage(),
    FavotitePage(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Navigation Bar'),
      ),
      body: _pages[_currentIndex], // Muestra la página seleccionada
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Casa',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Billetera',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: 'Guardado',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Página de Inicio', style: TextStyle(fontSize: 24)),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Página de Configuración', style: TextStyle(fontSize: 24)),
    );
  }
}
