import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:convert_coin_wallet/models/WalletClass.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPage createState() => _WalletPage();
}

class _WalletPage extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    final conversionesWaller = Provider.of<WalletMoney>(context);
    final items = conversionesWaller.conversiones;

    // Calcular la suma de todos los montos finales, manejando valores nulos
    final double sumaMontosFinales = items.fold(
      0.0,
      (sum, conversion) => sum + (conversion.montoConvertido ?? 0.0),
    );

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
                        "\$${sumaMontosFinales.toStringAsFixed(0)}", // Mostrar la suma redondeada
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
                  children: items.map((conversion) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color:
                          Color(0xFFF4F0FF), // Color de fondo similar al diseño
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Moneda y valor de origen
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  conversion.monedaOriginal,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  conversion.montoOriginal.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            // Icono de flecha
                            Icon(
                              Icons.arrow_forward,
                              size: 24,
                              color: Colors.black,
                            ),
                            // Moneda y valor de destino
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  conversion.monedaConvertida,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\$${(conversion.montoConvertido ?? 0).toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            // Botón de eliminar
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => conversionesWaller
                                  .eliminarConversion(conversion.indice),
                            ),
                          ],
                        ),
                      ),
                    );
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
