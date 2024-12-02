import 'package:flutter/material.dart';
import 'package:convert_coin_wallet/models/MonedasClass.dart';
import 'package:convert_coin_wallet/models/MonedaClass.dart';

class HomePage extends StatelessWidget {
  final Monedas monedas = Monedas([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return _buildCurrencyCard(moneda); // Llamada a la función
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyCard(Moneda moneda) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: SizedBox(
        height: 130, // Altura fija para la tarjeta
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5FF), // Fondo lavanda claro
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            children: [
              SizedBox(width: 12),
              Image.asset(
                'assets/images/argentina_flag.png', // Ruta de la imagen de bandera
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    moneda.moneda,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '   \$1',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 70),
              Icon(Icons.arrow_forward, size: 24),
              SizedBox(width: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'CLP',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${moneda.venta.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
