import 'package:flutter/material.dart';

class OrderNumBtn extends StatelessWidget {
  const OrderNumBtn({Key? key, required this.orderNum}) : super(key: key);

  final int orderNum;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => {},
        style: OutlinedButton.styleFrom(minimumSize: const Size(200, 100)),
        child: Text(
          orderNum.toString(),
          style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold
          ),
        )
    );
  }
}
