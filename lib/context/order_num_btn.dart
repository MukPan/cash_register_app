import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../component/order_num.dart';
import '../page/confirm_order_page.dart';
import '../main.dart';

class OrderNumBtn extends HookConsumerWidget {
  const OrderNumBtn({Key? key, required this.orderNum}) : super(key: key);
  ///注文番号
  final int orderNum;

  ///会計画面への遷移メソッド
  void moveConfirmOrderPage(BuildContext context, WidgetRef ref) {
    //状態の更新(選択中の注文番号)
    ref.read(selectedOrderNumProvider.notifier)
      .changeState(orderNum);

    //次ページの移動
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ConfirmOrderPage()
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
        onPressed: () => moveConfirmOrderPage(context, ref),
        style: OutlinedButton.styleFrom(minimumSize: const Size(200, 100)),
        child: OrderNum(orderNum: orderNum)
    );
  }
}



