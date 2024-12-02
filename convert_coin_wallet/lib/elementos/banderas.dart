class Bandera {
  final String ruta; // Ruta de la imagen
  final String name; // Nombre de la moneda o país

  Bandera(this.ruta, this.name);
}

class Banderas {
  final List<Bandera> banderas;

  // Constructor que inicializa la lista de banderas
  Banderas(this.banderas);

  // Método para cargar las banderas
  void cargarBanderas() {
    banderas.add(Bandera('assets/images/chile_flag.png', 'CLP'));
    banderas.add(Bandera('assets/images/argentina_flag.png', 'ARS'));
    banderas.add(Bandera('assets/images/EEUU_flag.png', 'USD'));
    banderas.add(Bandera('assets/images/españa_flag.png', 'EUR'));
    banderas.add(Bandera('assets/images/brasil_flag.png', 'BRL'));
    banderas.add(Bandera('assets/images/uruguay_flag.png', 'UYU'));
    // Añade tantas banderas como necesites
  }

  String? getRutaPorNombre(String name) {
    try {
      final bandera = banderas.firstWhere((bandera) => bandera.name == name);
      return bandera.ruta;
    } catch (e) {
      return 'assets/images/error.png';
    }
  }
}
