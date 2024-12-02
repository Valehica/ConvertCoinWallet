class Moneda {
  final double compra;
  final double venta;
  final double ultimoCierre;
  final String nombre;
  final String moneda;
  final String fechaActualizacion;

  Moneda({
    required this.compra,
    required this.venta,
    required this.ultimoCierre,
    required this.nombre,
    required this.moneda,
    required this.fechaActualizacion,
  });

  // Constructor para crear una instancia a partir de un JSON
  factory Moneda.fromJson(Map<String, dynamic> json) {
    return Moneda(
      compra: (json['compra'] ?? 0).toDouble(),
      venta: (json['venta'] ?? 0).toDouble(),
      ultimoCierre: (json['ultimoCierre'] ?? 0).toDouble(),
      nombre: json['nombre'] ?? '',
      moneda: json['moneda'] ?? '',
      fechaActualizacion: json['fechaActualizacion'] ?? '',
    );
  }

  // Método para convertir una instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'compra': compra,
      'venta': venta,
      'ultimoCierre': ultimoCierre,
      'nombre': nombre,
      'moneda': moneda,
      'fechaActualizacion': fechaActualizacion,
    };
  }
}
