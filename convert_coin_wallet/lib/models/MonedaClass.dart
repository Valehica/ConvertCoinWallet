class Moneda {
  final int id;
  final double compra;
  final double venta;
  final double ultimocierre;
  final String nombre;
  final String moneda;
  final String fechaActualizacion;

  Moneda(this.id, this.compra, this.venta, this.ultimocierre, this.nombre, this.moneda,
      this.fechaActualizacion);

Map<String, dynamic> toMap() {
    return {
      'id': id,
      'compra': compra,
      'venta': venta,
      'ultimocierre': ultimocierre,
      'nombre': nombre,
      'moneda': moneda,
      'fechaActualizacion': fechaActualizacion,
    };
  }
}