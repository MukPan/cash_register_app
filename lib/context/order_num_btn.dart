import 'package:flutter/material.dart';

import '../component/order_num.dart';
import '../page/confirm_order_page.dart';

class OrderNumBtn extends StatelessWidget {
  const OrderNumBtn({Key? key, required this.orderNum}) : super(key: key);
  ///注文番号
  final int orderNum;

  ///会計画面への遷移メソッド
  void moveConfirmOrderPage(BuildContext context) => {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ConfirmOrderPage(orderNum: orderNum)
    ))
  };

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => {moveConfirmOrderPage(context)},
        style: OutlinedButton.styleFrom(minimumSize: const Size(200, 100)),
        child: OrderNum(orderNum: orderNum)
    );
  }
}
