import 'package:flutter/material.dart';
import 'package:convert_coin_wallet/models/MonedasClass.dart';
import 'package:convert_coin_wallet/models/MonedaClass.dart';

class HomePage extends StatelessWidget {
  Monedas monedas = Monedas([
    Moneda(2000.0, 2000.0, 1990.0, 'DLR', 'USD', '2024-12-01'),
    Moneda(1500.0, 1505.0, 1503.0, 'EUR', 'EUR', '2024-12-01'),
    Moneda(1000.0, 1002.0, 998.0, 'GBP', 'GBP', '2024-12-01'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Monedas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: monedas.totalMonedas.length,
              itemBuilder: (context, index) {
                final moneda = monedas.totalMonedas[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5FF), // Fondo lavanda claro
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              moneda.moneda,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$${moneda.compra.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/argentina_flag.png', // Bandera de EEUU
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 16),
                            Icon(Icons.arrow_forward, size: 24),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CLP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\$${moneda.venta.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
