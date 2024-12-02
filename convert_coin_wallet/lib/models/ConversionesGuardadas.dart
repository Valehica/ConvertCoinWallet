import 'package:flutter/foundation.dart';

// Clase para representar una conversión
class Conversion {
  final double? montoOriginal;
  final double? montoConvertido;
  final String monedaOriginal;
  final String monedaConvertida;

  Conversion({
    required this.montoOriginal,
    required this.montoConvertido,
    required this.monedaOriginal,
    required this.monedaConvertida,
  });
}

// Clase para manejar las conversiones guardadas
class ConversionesGuardadas with ChangeNotifier {
  List<Conversion> _conversiones = [];

  List<Conversion> get conversiones => _conversiones;

  void agregarConversion(Conversion conversion) {
    _conversiones.add(conversion);
    notifyListeners(); // Notifica a los listeners para actualizar la UI
  }

  void eliminarConversion(int index) {
    _conversiones.removeAt(index);
    notifyListeners(); // Notifica a los listeners para actualizar la UI
  }
}
