import 'package:flutter/material.dart';

import 'package:convert_coin_wallet/models/MonedaClass.dart';
import 'package:convert_coin_wallet/elementos/Repository.dart';
import 'package:convert_coin_wallet/elementos/DatabaseHelper.dart';
import 'package:convert_coin_wallet/elementos/banderas.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Repository repository = Repository();
  final Banderas banderas = Banderas([]);
  late Future<List<Moneda>> _monedas =
      Future.value([]); // Lista futura de monedas
  List<Moneda> _filteredMonedas = []; // Lista filtrada para búsqueda
  final TextEditingController _searchController = TextEditingController();
// Lista futura de monedas

  @override
  void initState() {
    super.initState();
    _syncAndLoadData();
    _searchController.addListener(_filterMonedas);
  }

  void _filterMonedas() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      // Solo filtra si los datos ya han sido cargados
      if (_monedas != null) {
        _monedas.then((monedas) {
          _filteredMonedas = monedas
              .where((moneda) => moneda.moneda
                  .toLowerCase()
                  .contains(query)) // Filtro por nombre
              .toList();
        });
      }
    });
  }

  // Sincroniza los datos desde la API y recarga la lista
  Future<void> _syncAndLoadData() async {
    try {
      await repository.syncData(); // Llama al método para sincronizar datos
      setState(() {
        _monedas = repository.getLocalData(); // Carga los datos desde SQLite
      });
    } catch (e) {
      print('Error al sincronizar y cargar datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    banderas.cargarBanderas();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController, // Asocia el controlador
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
            child: FutureBuilder<List<Moneda>>(
              future: _monedas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay datos disponibles'));
                } else {
                  final monedas = _filteredMonedas.isEmpty
                      ? snapshot
                          .data! // Si no hay búsqueda, muestra todos los datos
                      : _filteredMonedas; // Si hay búsqueda, muestra los filtrados
                  return ListView.builder(
                    itemCount: monedas.length,
                    itemBuilder: (context, index) {
                      final moneda = monedas[index];
                      return _buildCurrencyCard(moneda);
                    },
                  );
                }
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
      child: GestureDetector(
        onTap: () {
          // Aquí va la acción que quieres realizar cuando se toque la card.
          // En este caso, mostramos un SnackBar como ejemplo.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Moneda seleccionada: ${moneda.moneda}'),
              duration: Duration(seconds: 2),
            ),
          );
        },
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
                  banderas
                      .getRutaPorNombre(moneda.moneda)
                      .toString(), // Ruta de la imagen de bandera
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
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
      ),
    );
  }
}
