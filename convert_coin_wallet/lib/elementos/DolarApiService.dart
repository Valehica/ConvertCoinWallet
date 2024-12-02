import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:convert_coin_wallet/models/MonedaClass.dart';

class DolarApiService {
  static const String _baseUrl = 'https://cl.dolarapi.com';
  static const String _endpoint = '/v1/cotizaciones';

  Future<List<Moneda>> getMonedas() async {
    final url = Uri.parse('$_baseUrl$_endpoint');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Moneda.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error al obtener las cotizaciones: ${response.statusCode}');
    }
  }
}
