import 'package:cash_register_app/component/money_count_down_btn.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../provider/money_count_provider_family.dart';
import '../provider/various_amounts_provider_family.dart';

//TODO: 編集ボタンを押してから数を変更できるようにする
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
  void _countUpMoney(WidgetRef ref) {
    ref.read(moneyCountProviderFamily(moneyId).notifier).state++;
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
              _countUpMoney(ref); //カウント+1
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
        MoneyCountDownBtn(moneyId: moneyId)

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
