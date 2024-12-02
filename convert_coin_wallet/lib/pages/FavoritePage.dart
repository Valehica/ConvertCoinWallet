import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:convert_coin_wallet/models/ConversionesGuardadas.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final conversiones = Provider.of<ConversionesGuardadas>(context);
    final items =
        conversiones.conversiones; // Accede a la lista de conversiones

    return Scaffold(
      appBar: AppBar(
        title: Text('Conversiones Guardadas'),
      ),
      body: ListView.builder(
        itemCount: items.length, // Usar items.length
        itemBuilder: (context, index) {
          final conversion =
              items[index]; // Usar items en lugar de conversiones
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                'Monto Original: \$${conversion.montoOriginal?.toStringAsFixed(2)} ${conversion.monedaOriginal}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Monto Convertido: \$${conversion.montoConvertido?.toStringAsFixed(2)} ${conversion.monedaConvertida}',
              ),
            ),
          );
        },
      ),
    );
  }
}
