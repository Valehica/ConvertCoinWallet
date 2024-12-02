import 'package:flutter/material.dart';
import 'package:convert_coin_wallet/elementos/AppColors.dart';
import 'package:convert_coin_wallet/models/MonedaClass.dart';

import 'package:provider/provider.dart';
import 'package:convert_coin_wallet/models/ConversionesGuardadas.dart';

class MonedaDescription extends StatefulWidget {
  final Moneda moneda;

  const MonedaDescription({
    required this.moneda,
    Key? key,
  }) : super(key: key);

  @override
  _MonedaDescriptionState createState() => _MonedaDescriptionState();
}

class _MonedaDescriptionState extends State<MonedaDescription> {
  int _currentIndex = 0; // Índice del TabBar (0 = Compra, 1 = Venta)
  TextEditingController _controller = TextEditingController();
  double? _resultadoConversion;
  double? ingresoMoneda;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conversion',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.background),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.secondary,
      ),
      body: Column(
        children: [
          // Navigation Bar
          Container(
            color: AppColors.backgroundSecundary,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentIndex = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      color: _currentIndex == 0
                          ? AppColors.backgroundSecundary
                          : AppColors.backgroundSecundary,
                      child: Text('Compra',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _currentIndex == 0
                                ? AppColors.secondary
                                : AppColors.primary,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentIndex = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      color: _currentIndex == 1
                          ? AppColors.backgroundSecundary
                          : AppColors.backgroundSecundary,
                      child: Text('Venta',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _currentIndex == 0
                                ? AppColors.primary
                                : AppColors.secondary,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Mostrar la vista de Compra o Venta según el índice seleccionado
          if (_currentIndex == 0) _buildCompraView() else _buildVentaView(),

          const SizedBox(height: 20),
          const SizedBox(height: 10),
          // Fecha de actualización
          Text(
            'Fecha de actualización: ${widget.moneda.fechaActualizacion}',
            style: const TextStyle(fontSize: 16, color: AppColors.primary),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Función para la vista de Compra
  Widget _buildCompraView() {
    final conversionesGuardadas = Provider.of<ConversionesGuardadas>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Valor:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      "\$" + widget.moneda.compra.toStringAsFixed(2),
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      widget.moneda.moneda,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          const Text(
            'Ingrese monto en CLP ',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: '\$',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              setState(() {
                double? montoIngresado = double.tryParse(value);

                // Comprobamos si montoIngresado no es nulo y si widget.moneda.compra no es nulo
                if (montoIngresado != null && widget.moneda.compra != null) {
                  ingresoMoneda = montoIngresado;
                  if (widget.moneda.compra != 0) {
                    _resultadoConversion =
                        montoIngresado / widget.moneda.compra!;
                  } else {
                    _resultadoConversion =
                        null; // Si el valor de compra es 0, asignamos null
                  }
                } else {
                  _resultadoConversion =
                      null; // Si montoIngresado o widget.moneda.compra son nulos
                }
              });
            },
          ),
          const SizedBox(height: 20),
          const Text('Esto equivale a:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Información de la tarjeta
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            _resultadoConversion == null
                                ? '\$0'
                                : '\$${_resultadoConversion!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: Text(
                            widget.moneda.moneda,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Icono de compartir
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Acción al presionar el icono de compartir
                      print('Compartir información de la moneda');
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 200, // Ajusta el ancho según lo desees
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  conversionesGuardadas.agregarConversion(Conversion(
                      montoOriginal: ingresoMoneda,
                      montoConvertido: _resultadoConversion,
                      monedaOriginal: 'CLP',
                      monedaConvertida: widget.moneda.toString()));
                },
                child: const Text(
                  'Guardar conversión',
                  style: TextStyle(fontSize: 16, color: AppColors.background),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Función para la vista de Venta
  Widget _buildVentaView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Valor:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      "\$" + widget.moneda.venta.toStringAsFixed(2),
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      "CLP",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Ingrese monto en ' + widget.moneda.moneda,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: '\$',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              setState(() {
                double? montoIngresado = double.tryParse(value);
                if (montoIngresado != null) {
                  _resultadoConversion = montoIngresado * widget.moneda.venta;
                } else {
                  _resultadoConversion = null;
                }
              });
            },
          ),
          const SizedBox(height: 20),
          const Text('Esto equivale a:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Información de la tarjeta
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            _resultadoConversion == null
                                ? '\$0'
                                : '\$${_resultadoConversion!.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: Text(
                            widget.moneda.moneda,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Icono de compartir
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Acción al presionar el icono de compartir
                      print('Compartir información de la moneda');
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Guardar conversión',
                    style: TextStyle(fontSize: 16, color: AppColors.background),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Acción del botón adicional
                    print('Botón adicional presionado');
                  },
                  child: const Text(
                    'Botón adicional',
                    style: TextStyle(fontSize: 16, color: AppColors.background),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
