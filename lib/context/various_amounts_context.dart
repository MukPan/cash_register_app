import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../provider/total_amount_notifier.dart';
import '../provider/money_count_provider_family.dart';
import '../provider/various_amounts_provider_family.dart';


class VariousAmountsContext extends HookConsumerWidget {
  const VariousAmountsContext({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //カンマ挿入フォーマット
    final commaInsertFormat = NumberFormat("#,###");
    // //合計 commaInsertFormat.format
    // final int totalAmount = ref.watch(totalAmountProvider);
    // //お預り
    // final int depositAmount = moneyIdList
    //     .map((moneyId) => moneyIdStrToInt[moneyId] !* ref.watch(moneyCountProviderFamily(moneyId)).toInt())
    //     .map((amountNum) => amountNum.toInt())
    //     .reduce((sum, amount) => sum + amount);
    // //お釣り
    // final int changeAmount = depositAmount - totalAmount;

    //合計
    final int totalAmount = ref.watch(variousAmountsProviderFamily(VariousAmounts.totalAmount));
    //お預り
    final int depositAmount = ref.watch(variousAmountsProviderFamily(VariousAmounts.depositAmount));
    //お釣り
    final int changeAmount = ref.watch(variousAmountsProviderFamily(VariousAmounts.changeAmount));

    //お釣り表示の色
    final MaterialColor changeDisplayColor;

    if (changeAmount == 0) //ちょうど
      { changeDisplayColor = Colors.grey; }
    else if (changeAmount > 0) //お釣り
      { changeDisplayColor = Colors.lightBlue; }
    else //不足
      { changeDisplayColor = Colors.pink; }

    //カンマ挿入
    final String totalAmountStr = commaInsertFormat.format(totalAmount);
    final String depositAmountStr = commaInsertFormat.format(depositAmount);
    final String changeAmountStr = commaInsertFormat.format(changeAmount);


    return Center(
        child: Column(children: [ //various_amounts_context
          RichText(
            text: TextSpan(children: [
                  const TextSpan(text: "合計 : \n", style: TextStyle(fontSize: 20)),
                  TextSpan(text: totalAmountStr, style: const TextStyle(fontSize: 80)),
                  const TextSpan(text: " 円", style: TextStyle(fontSize: 30))
                ]
            ),
          ),

          RichText(
            text: TextSpan(children: [
                  const TextSpan(text: "お預り : \n", style: TextStyle(fontSize: 20)),
                  TextSpan(text: depositAmountStr, style: const TextStyle(fontSize: 80)),
                  const TextSpan(text: " 円", style: TextStyle(fontSize: 30))
                ]
            ),
          ),

          RichText(
            text: TextSpan(children: [
                  const TextSpan(text: "お釣り(差分) : \n", style: TextStyle(fontSize: 20)),
                  TextSpan(text: changeAmountStr, style: TextStyle(fontSize: 80, color: changeDisplayColor)),
                  TextSpan(text: " 円", style: TextStyle(fontSize: 30, color: changeDisplayColor))
                ]
            ),
          )
        ],)
    );
  }
}

