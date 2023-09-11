
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../component/money_counter_btn.dart';
import '../provider/money_count_provider_family.dart';




///貨幣を入力するグリッド
class CashRegisterContext extends StatelessWidget {
  const CashRegisterContext({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,     //ボックス左右間のスペース
        mainAxisSpacing: 10,      //ボックス上下間のスペース
        crossAxisCount: 3,        //ボックスを横に並べる数
      ),
      itemCount: moneyIdList.length,
      //指定した要素の数分を生成
      itemBuilder: (context, index) => MoneyCounterBtn(moneyId: moneyIdList[index], index: index),
    );
  }
}
