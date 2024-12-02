import 'package:flutter/material.dart';
import 'package:convert_coin_wallet/elementos/ConversionCard.dart';
import 'package:convert_coin_wallet/models/ConversionesClass.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPage createState() => _WalletPage();
}

class _WalletPage extends State<WalletPage> {
  List<Conversion> conversions = [
    Conversion("CLP", 2000, "DLR", 2.0),
    Conversion("CLP", 5000, "USD", 6.0),
    Conversion("EUR", 20, "GBP", 17.0),
    Conversion("EUR", 20, "GBP", 17.0),
    Conversion("EUR", 20, "GBP", 17.0),
    Conversion("EUR", 20, "GBP", 17.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarjeta superior
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Moneda:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        "\$2.000",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Text(
                        "CLP",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Texto de Conversiones
            Text(
              "Conversiones",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Lista de conversiones con scroll
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: conversions.map((conversion) {
                    return ConversionCard(conversion: conversion);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),

      // Botón flotante
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción del botón
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
