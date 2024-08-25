import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String currency;
  final String price;
  final String cardName;
  ReusableCard(
      {required this.currency, required this.price, required this.cardName});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '$cardName $price $currency',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
