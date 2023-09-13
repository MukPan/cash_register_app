import 'package:cash_register_app/provider/various_amounts_provider_family.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ChangeDisplay extends HookConsumerWidget {
  const ChangeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int changeAmount = ref.read(variousAmountsProviderFamily(VariousAmounts.changeAmount));
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
                const TextSpan(text: "お釣り :\n", style: TextStyle(fontSize: 20)),
                TextSpan(text: NumberFormat("#,###").format(changeAmount), style: const TextStyle(fontSize: 80)),
                const TextSpan(text: " 円", style: TextStyle(fontSize: 30))
              ]
          ),
        ),
      )
    );
  }
}
