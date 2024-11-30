import 'package:flutter/material.dart';
import 'package:convert_coin_wallet/models/ConversionesClass.dart';

import 'package:convert_coin_wallet/elementos/ConversionCard.dart';
import 'package:convert_coin_wallet/models/ConversionesClass.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  // Lista de conversiones para mostrar
  List<Conversion> conversions = [
    Conversion("CLP", 2000, "DLR", 2.0),
    Conversion("CLP", 5000, "USD", 6.0),
    Conversion("EUR", 20, "GBP", 17.0),
    Conversion("EUR", 20, "GBP", 17.0),
    Conversion("EUR", 20, "GBP", 17.0),
    Conversion("EUR", 20, "GBP", 17.0),
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Filtrar conversiones según el texto de búsqueda
    final filteredConversions = conversions.where((conversion) {
      final fromCurrency = conversion.fromCurrency.toLowerCase();
      final toCurrency = conversion.toCurrency.toLowerCase();
      return fromCurrency.contains(searchQuery.toLowerCase()) ||
          toCurrency.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Buscar',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          // Lista con scroll vertical
          Expanded(
            child: ListView.builder(
              itemCount: filteredConversions.length,
              itemBuilder: (context, index) {
                return ConversionCard(conversion: filteredConversions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
