import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:convert_coin_wallet/models/ConversionesGuardadas.dart';
import 'package:convert_coin_wallet/elementos/banderas.dart';
import 'package:convert_coin_wallet/elementos/AppColors.dart';

class Favoritepage extends StatefulWidget {
  @override
  _Favoritepage createState() => _Favoritepage();
}

class _Favoritepage extends State<Favoritepage> {
  @override
  Widget build(BuildContext context) {
    final conversiones = Provider.of<ConversionesGuardadas>(context);
    final items = conversiones.conversiones;

    ;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lista de conversiones con scroll
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: items.map((conversion) {
                    return _buildCurrencyCard(conversion, conversiones);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCurrencyCard(
    Conversion conversion, ConversionesGuardadas conversiones) {
  final Banderas banderas = Banderas([]);
  banderas.cargarBanderas();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
    child: GestureDetector(
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecundary, // Light lavender background
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            // Flag for the original currency
            Image.asset(
              banderas.getRutaPorNombre(conversion.monedaOriginal).toString(),
              width: 30,
              height: 30,
            ),
            SizedBox(width: 10),

            // Info for the original currency
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversion.monedaOriginal ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // Reduced font size for smaller devices
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Ensure text doesn't overflow
                  ),
                  SizedBox(height: 6),
                  Text(
                    '\$${(conversion.montoOriginal ?? 0).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14, // Adjust font size
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),

            // Arrow icon
            Icon(Icons.arrow_forward, size: 24),
            SizedBox(width: 10),

            // Flag for the converted currency
            Image.asset(
              banderas.getRutaPorNombre(conversion.monedaConvertida).toString(),
              width: 30,
              height: 30,
            ),
            SizedBox(width: 10),

            // Info for the converted currency
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    conversion.monedaConvertida ?? '',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Ensure text doesn't overflow
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${(conversion.montoConvertido ?? 0).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () =>
                  conversiones.eliminarConversion(conversion.indice),
            ),
          ],
        ),
      ),
    ),
  );
}
