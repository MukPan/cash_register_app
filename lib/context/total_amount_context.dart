import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../main.dart';
import 'package:intl/intl.dart';

import '../provider/total_amount_notifier.dart';
import '../provider/various_amounts_provider_family.dart';

class TotalAmountContext extends HookConsumerWidget {
  const TotalAmountContext({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //カンマを挿入した合計金額
    final totalAmountStr = NumberFormat("#,###")
        .format(ref.watch(variousAmountsProviderFamily(VariousAmounts.totalAmount)));


    return Container(
      width: MediaQuery.of(context).size.width/2.0 - 60.0,
      margin: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
          border: Border.all(width: 1)
      ),
      child: Center(
          child: RichText(
            text: TextSpan(
                children: [
                  const TextSpan(text: "合計 : \n", style: TextStyle(fontSize: 20)),
                  TextSpan(text: totalAmountStr, style: const TextStyle(fontSize: 80)),
                  const TextSpan(text: " 円", style: TextStyle(fontSize: 30))
                ]
            ),
          )
      ),
    );
  }
}
