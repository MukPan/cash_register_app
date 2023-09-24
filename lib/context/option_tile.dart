import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({Key? key, required this.optName}) : super(key: key);

  ///オプション名
  final String optName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // これで両端に寄せる
      children: [
        Text(optName),
        ElevatedButton(
            onPressed: () {},
            child: const Text("あり"),
        ),
      ],
    );
  }
}
