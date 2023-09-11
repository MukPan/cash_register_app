import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemName extends StatelessWidget {
  const ItemName({Key? key, required this.itemName}) : super(key: key);

  ///商品名
  final String itemName;


  @override
  Widget build(BuildContext context) {
    return Text(
      itemName,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0
      ),
    );
  }
}
