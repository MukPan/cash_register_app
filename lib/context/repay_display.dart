import 'package:cash_register_app/provider/various_amounts_provider_family.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class RepayDisplay extends StatelessWidget {
  const RepayDisplay({Key? key, required this.repayAmount}) : super(key: key);

  ///払い戻し金額
  final int repayAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(30, 20, 30, 30),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 1)
        ),
        child: Center(
          child: RichText(
            text: TextSpan(
                children: [
                  const TextSpan(text: "払い戻し :\n", style: TextStyle(fontSize: 20)),
                  TextSpan(text: NumberFormat("#,###").format(repayAmount), style: const TextStyle(fontSize: 80)),
                  const TextSpan(text: " 円", style: TextStyle(fontSize: 30))
                ]
            ),
          ),
        )
    );
  }
}
