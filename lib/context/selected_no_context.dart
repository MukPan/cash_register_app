import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../component/order_num.dart';
import '../provider/selected_order_num_notifier.dart';

///選択した注文番号Widget
class SelectedNoContext extends HookConsumerWidget {
  const SelectedNoContext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int orderNum = ref.read(selectedOrderNumProvider);

    return Row(children: [
      const Text("注文番号 : ", style: TextStyle(fontSize: 20)),
      OrderNum(orderNum: orderNum),
    ],);
  }
}
