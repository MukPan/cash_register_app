import 'package:flutter/material.dart';

///太文字の注文番号を表示するTextWidget
class OrderNum extends StatelessWidget {
  const OrderNum({Key? key, required this.orderNum}) : super(key: key);

  final int orderNum;

  @override
  Widget build(BuildContext context) {
    return Text(
        orderNum.toString(),
        style: const TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold
    ));
  }
}
