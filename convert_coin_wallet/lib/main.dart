import 'package:flutter/material.dart';
import 'pages/NavegationBar.dart';

import 'package:convert_coin_wallet/elementos/DatabaseHelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationBarApp(),
    );
  }
}
