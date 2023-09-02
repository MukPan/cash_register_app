import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../provider/money_count_provider_family.dart';
import '../provider/total_amount_notifier.dart';
import '../provider/various_amounts_provider_family.dart';

class MoneyCounterBtn extends HookConsumerWidget {
  const MoneyCounterBtn({Key? key, required this.moneyId, required this.index}) : super(key: key);

  ///貨幣の名称(Familyのid)
  final String moneyId;
  ///貨幣イメージを呼び出すためのindex
  final int index;
  ///イメージのパスリスト
  static const List<String> _moneyImgPathList = [
    "images/money_1yen.png",
    "images/money_5yen.png",
    "images/money_10yen.png",
    "images/money_50yen.png",
    "images/money_100yen.png",
    "images/money_500yen.png",
    "images/money_1000yen.png",
    "images/money_5000yen.png",
    "images/money_10000yen.png",
  ];

  ///貨幣のカウントに1を足す
  void countUpMoney(WidgetRef ref) {
    ref.read(moneyCountProviderFamily(moneyId).notifier).state++;
  }

  ///合計、お預り、お釣りの状態を更新する
  void changeVariousAmounts(WidgetRef ref) {
    //合計 commaInsertFormat.format
    final int totalAmount = ref.read(variousAmountsProviderFamily(VariousAmounts.totalAmount));
    //お預り
    final int depositAmount = moneyIdList
        .map((moneyId) => moneyIdStrToInt[moneyId] !* ref.watch(moneyCountProviderFamily(moneyId)).toInt())
        .map((amountNum) => amountNum.toInt())
        .reduce((sum, amount) => sum + amount);
    //お釣り
    final int changeAmount = depositAmount - totalAmount;

    //staete更新
    ref.read(variousAmountsProviderFamily(VariousAmounts.totalAmount).notifier).state = totalAmount;
    ref.read(variousAmountsProviderFamily(VariousAmounts.depositAmount).notifier).state = depositAmount;
    ref.read(variousAmountsProviderFamily(VariousAmounts.changeAmount).notifier).state = changeAmount;
  }



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int moenyCount = ref.watch(moneyCountProviderFamily(moneyId));

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade100,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)) //角ばったボタン
              ),

            ),
            onPressed: () {
              countUpMoney(ref); //カウント+1
              changeVariousAmounts(ref); //金額state更新
            },

            child: Column(children: [
              Text(moneyId), //貨幣名称
              Image.asset(_moneyImgPathList[index], height: 80), //貨幣イメージ
              Text(moenyCount.toString()) //入力枚数
            ],),
          ),
        ),
        //マイナスボタン
        SizedBox(
          width: 30,
          height: 30,
          child: IconButton(
            icon: const Icon(Icons.remove, color: Colors.white),
            onPressed: () {},
            padding: EdgeInsets.zero, //忘れるな！！！！！！！！！！ないとアイコンが飛び出すぞ！！！！！！！！！
            alignment: Alignment.center, //忘れるな！！！！！！！！！！ないとアイコンが飛び出すぞ！！！！！！！！！
            iconSize: 15,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38),
            ),
          ),
        )

      ],
    );
  }
}

// CircleAvatar(
// radius: 10,
// backgroundColor: Colors.black,
// child: Center(
// child: IconButton(
// icon: const Icon(Icons.remove, color: Colors.white,),
// onPressed: () {},
// splashRadius: 0.1,
// ),
// )
// ),
