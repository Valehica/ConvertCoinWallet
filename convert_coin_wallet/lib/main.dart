import 'package:flutter/material.dart';
import 'pages/NavegationBar.dart'; // Verifica que la ruta sea correcta.
import 'package:convert_coin_wallet/elementos/DatabaseHelper.dart';

import 'package:provider/provider.dart';
import 'package:convert_coin_wallet/models/ConversionesGuardadas.dart';
import 'package:convert_coin_wallet/models/WalletClass.dart';
import 'package:convert_coin_wallet/pages/SplashScreen.dart'; // Importa la pantalla SplashScreen.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ConversionesGuardadas()),
      ChangeNotifierProvider(create: (context) => WalletMoney()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // Define la ruta inicial.
      routes: {
        '/splash': (context) => SplashScreen(), // Pantalla de inicio.
        '/home': (context) => NavigationBarApp(), // Pantalla principal.
      },
    );
  }
}
