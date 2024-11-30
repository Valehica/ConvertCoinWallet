import 'package:flutter/material.dart';
import 'package:convert_coin_wallet/models/ConversionesClass.dart';

class ConversionCard extends StatelessWidget {
  final Conversion conversion;

  const ConversionCard({Key? key, required this.conversion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.purple.shade50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${conversion.fromCurrency}\n\$${conversion.fromValue}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward, color: Colors.grey),
            Text(
              "\$${conversion.toValue}\n${conversion.toCurrency}",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
