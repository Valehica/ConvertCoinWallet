import 'package:flutter/foundation.dart';

// Clase para representar una conversión
class Wallet {
  final double? montoOriginal;
  final double? montoConvertido;
  final String monedaOriginal;
  final String monedaConvertida;

  Wallet({
    required this.montoOriginal,
    required this.montoConvertido,
    required this.monedaOriginal,
    required this.monedaConvertida,
  });
}

// Clase para manejar las conversiones guardadas
class WalletMoney with ChangeNotifier {
  List<Wallet> _conversiones = [];

  List<Wallet> get conversiones => _conversiones;

  void agregarConversion(Wallet conversion) {
    _conversiones.add(conversion);
    notifyListeners(); // Notifica a los listeners para actualizar la UI
  }

  void eliminarConversion(int index) {
    _conversiones.removeAt(index);
    notifyListeners(); // Notifica a los listeners para actualizar la UI
  }
}
