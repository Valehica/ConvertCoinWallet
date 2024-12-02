import 'package:flutter/material.dart';
import 'package:convert_coin_wallet/DTBS/DolarApiService.dart';
import 'package:convert_coin_wallet/models/MonedaClass.dart';

class MonedasScreen extends StatelessWidget {
  final DolarApiService apiService = DolarApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizaciones de Monedas'),
      ),
      body: FutureBuilder<List<Moneda>>(
        future: apiService.getMonedas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay datos disponibles'));
          } else {
            final monedas = snapshot.data!;
            return ListView.builder(
              itemCount: monedas.length,
              itemBuilder: (context, index) {
                final moneda = monedas[index];
                return ListTile(
                  title: Text(moneda.nombre),
                  subtitle: Text(
                    'Compra: ${moneda.compra}\nVenta: ${moneda.venta}\nÚltimo Cierre: ${moneda.ultimoCierre}',
                  ),
                  trailing: Text(moneda.fechaActualizacion),
                );
              },
            );
          }
        },
      ),
    );
  }
}
