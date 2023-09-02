import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../provider/money_count_provider_family.dart';
import '../provider/various_amounts_provider_family.dart';

class MoneyCountDownBtn extends HookConsumerWidget {
  const MoneyCountDownBtn({Key? key, required this.moneyId}) : super(key: key);

  ///貨幣の名称(Familyのid)
  final String moneyId;

  ///入力枚数から1枚減らす
  void _moneyCountDown(WidgetRef ref) {
    //stateを減らす
    ref.read(moneyCountProviderFamily(moneyId).notifier).state--;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int nowMoneyCount = ref.watch(moneyCountProviderFamily(moneyId));


    return SizedBox(
      width: 30,
      height: 30,
      child: IconButton(
        icon: const Icon(Icons.remove, color: Colors.white),
        onPressed: (nowMoneyCount <= 0) ? null : () {
          _moneyCountDown(ref); //カウントダウン
          changeVariousAmounts(ref); //状態更新
        },
        padding: EdgeInsets.zero, //忘れるな！！！！！！！！！！ないとアイコンが飛び出すぞ！！！！！！！！！
        alignment: Alignment.center, //忘れるな！！！！！！！！！！ないとアイコンが飛び出すぞ！！！！！！！！！
        iconSize: 15,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black38),
        ),
      ),
    );
  }

}