
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
    return Container(
      width: MediaQuery.of(context).size.width/2.0 - 60.0, //TODO: paddingを試す
      color: CupertinoColors.systemGrey3,
      margin: const EdgeInsets.all(30.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,     //ボックス左右間のスペース
          mainAxisSpacing: 10,      //ボックス上下間のスペース
          crossAxisCount: 3,        //ボックスを横に並べる数
        ),
        itemCount: moneyIdList.length,
        //指定した要素の数分を生成
        itemBuilder: (context, index) => MoneyCounterBtn(moneyId: moneyIdList[index], index: index),
      ),
    );
  }
}
