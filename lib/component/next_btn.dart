import 'package:flutter/material.dart';

class NextBtn extends StatelessWidget {
  const NextBtn({Key? key, required this.moveNextPageFunc}) : super(key: key);

  final void Function(BuildContext) moveNextPageFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ),
        onPressed: () => {moveNextPageFunc(context)},
        child: const Text(
          "次へ",
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ),
    );
  }
}
