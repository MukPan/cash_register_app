import 'package:flutter/material.dart';

class NextBtn extends StatelessWidget {
  const NextBtn({Key? key, required this.moveNextPageFunc, this.isValid = true}) : super(key: key);

  ///次のページに遷移するための関数
  final void Function(BuildContext) moveNextPageFunc;

  ///ボタンが有効であるか
  final bool isValid;



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
        onPressed: isValid ? () => {moveNextPageFunc(context)} : null,
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
