import 'package:cash_register_app/component/order_num.dart';
import 'package:cash_register_app/provider/all_order_list_provider.dart';
import 'package:cash_register_app/provider/order_list_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../component/item_counter.dart';
import '../component/item_img.dart';
import '../component/item_name.dart';
import '../component/option_names.dart';
import '../component/subtotal.dart';
import '../provider/paid_num_list_provider.dart';
import 'item_tile.dart';

class CookingList extends HookConsumerWidget {
  const CookingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //支払い済み注文番号リスト
    final paidNumListAsyncVal = ref.watch(paidNumListProvider);
    // final allOrderListStream = ref.watch(allOrderListProvider);

    return paidNumListAsyncVal.when( //注文番号を監視
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text(error.toString()),
        data: (paidNumList) {
          if (paidNumList.isEmpty) return Container();
          return ListView.separated(
            itemCount: paidNumList.length,
            separatorBuilder: (context, index) => const Divider(height: 0, color: Colors.black,),
            itemBuilder: (parentContext, paidOrderNumIndex) {
              //注文番号リストに更新が入った分だけ新しい項目を作成する
              final orderListAsyncVal = ref.watch(orderListFamily(paidNumList[paidOrderNumIndex]));

              return orderListAsyncVal.when(
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text(error.toString()),
                data: (orderList) {

                  //注文番号
                  final paidOrderNum = paidNumList[paidOrderNumIndex];
                  return Row(
                    children: [
                      //注文番号(左)
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: OrderNum(orderNum: paidOrderNum),
                      ),
                      //オーダー一覧(右)
                      Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(left: BorderSide(color: Colors.grey)),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: orderList.length,
                              separatorBuilder: (context, index) => const Divider(height: 0),
                              itemBuilder: (context, index) {
                                //1つの注文番号の注文リスト
                                final orderObj = orderList[index];

                                return ItemTile(orderObj: orderObj);
                              },
                            ),
                          )
                      ),
                    ],
                  );
                }
              );
            },
          );
        }
    );
  }
}
// Padding(
// padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween, // これで両端に寄せる
// children: [
// //左寄り
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// textDirection: TextDirection.ltr, //L→R 指定しないとツールでエラー
// children: [
// //1行目
// ItemName(itemName: orderObj.itemName),
// //2行目以降
// OptionNames(optList: orderObj.optionList),
// //カウンタ
// ItemCounter(index: orderObj.itemQty)
// ],
// ),
// ),
// //右寄り
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.end, //center
// textDirection: TextDirection.ltr,
// children: [
// ItemImg(itemName: orderObj.itemName),
// Subtotal(orderObj: orderObj)
// ],
// ),
// )
// ],
// ),
// )