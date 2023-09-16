import 'package:cash_register_app/provider/all_order_list_provider.dart';
import 'package:cash_register_app/provider/order_list_family.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/paid_num_list_provider.dart';

class CookingList extends HookConsumerWidget {
  const CookingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //支払い済み注文番号リスト
    final paidNumListAsyncVal = ref.watch(paidNumListProvider);
    // final allOrderListStream = ref.watch(allOrderListProvider);

    return paidNumListAsyncVal.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text(error.toString()),
        data: (paidNumList) {
          if (paidNumList.isEmpty) return Container();
          return ListView.builder(
            itemCount: paidNumList.length,
            itemBuilder: (context, index) {
              final orderListAsyncVal = ref.watch(orderListFamily(paidNumList[index]));

              return orderListAsyncVal.when(
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text(error.toString()),
                data: (orderList) {
                  return Text(orderList[0].itemName, style: const TextStyle(fontSize: 50),);
                }
              );
            },
          );
        }
    );
  }
}
// RepaintBoundary(child: Text(),);

// final allOrderListStream = ref.watch(allOrderListProvider);
//
// return allOrderListStream.when(
// loading: () => const CircularProgressIndicator(),
// error: (error, stackTrace) => Text(error.toString()),
// data: (allOrderList) {
// if (allOrderList.isEmpty) return Container();
// return ListView.builder(
// itemCount: allOrderList.length,
// itemBuilder: (context, index) {
// return Text(allOrderList[index][0].itemName);
// },
// );
// }
// );