import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../main.dart';
import 'package:intl/intl.dart';

import '../object/order_params.dart';
import '../provider/various_amounts_provider_family.dart';

class TotalAmountContext extends HookConsumerWidget {
  const TotalAmountContext({Key? key, required this.orderListAsyVal}) : super(key: key);

  ///注文リストAsyVal
  final AsyncValue<DatabaseEvent> orderListAsyVal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //カンマを挿入した合計金額
    final totalAmountStr = NumberFormat("#,###")
        .format(ref.watch(variousAmountsProviderFamily(VariousAmounts.totalAmount)));

    return orderListAsyVal.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text(error.toString()),
      data: (event) {
        //注文リスト(複数の注文がリストになっている)
        final orderListSnap = event.snapshot.children.toList();
        //合計金額を計算
        final int total = orderListSnap
            .map((orderSnap) => OrderParams.getInstance(orderSnap).subtotal)
            .reduce((sum, price) => sum + price);

        return Container(
          margin: const EdgeInsets.fromLTRB(30, 20, 30, 30),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              border: Border.all(width: 1)
          ),
          child: Center(
              child: RichText(
                text: TextSpan(
                    children: [
                      const TextSpan(text: "合計 : \n", style: TextStyle(fontSize: 20)),
                      TextSpan(text: total.toString(), style: const TextStyle(fontSize: 80)),
                      const TextSpan(text: " 円", style: TextStyle(fontSize: 30))
                    ]
                ),
              )
          ),
        );
      }
    );


    return Container(
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 30),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
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
