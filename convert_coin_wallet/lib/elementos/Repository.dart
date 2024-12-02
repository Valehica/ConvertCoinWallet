import 'package:convert_coin_wallet/elementos/DatabaseHelper.dart';
import 'package:convert_coin_wallet/models/MonedaClass.dart';
import 'package:convert_coin_wallet/elementos/DolarApiService.dart';

class Repository {
  final DolarApiService apiService =
      DolarApiService(); // Instancia del servicio de API
  final DatabaseHelper dbHelper =
      DatabaseHelper.instance; // Instancia de la base de datos

  // Método para sincronizar datos desde la API a la base de datos
  Future<void> syncData() async {
    try {
      // Obtén los datos desde la API
      List<Moneda> monedas = await apiService.getMonedas();

      // Limpia la base de datos local y guarda los nuevos datos
      await dbHelper.deleteAll();
      for (var moneda in monedas) {
        await dbHelper.insertMoneda(moneda);
      }

      print(
          'Sincronización completa: ${monedas.length} monedas guardadas en la base de datos.');
    } catch (e) {
      print('Error al sincronizar datos: $e');
    }
  }

  // Método para cargar monedas desde la base de datos local
  Future<List<Moneda>> getLocalData() async {
    try {
      return await dbHelper.getMonedas();
    } catch (e) {
      print('Error al obtener datos locales: $e');
      return [];
    }
  }
}
