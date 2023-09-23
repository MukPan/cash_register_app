import 'package:cash_register_app/component/order_num.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../context/item_tile.dart';
import '../database/order_list_family.dart';
import '../object/order_params.dart';
import 'stack_item_tile.dart';

class RealtimeOrderList extends HookConsumerWidget {
  const RealtimeOrderList({
    Key? key,
    required this.orderNumListProvider,
    required this.subStateWidgetFunc,
    required this.emptyText,
    this.displayPrice = false,
    this.stackImage = false,
  }) : super(key: key);

  ///表示するリストのプロバイダー
  final StreamProvider<DatabaseEvent> orderNumListProvider;
  ///注文番号に働きかけるボタンsubStateWidgetFunc
  final Widget Function(int orderNum) subStateWidgetFunc;
  ///リストが空のときに表示するテキスト
  final String emptyText;
  ///価格の表示
  final bool displayPrice;
  ///画像を重ねる
  final bool stackImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //注文番号リスト
    final orderNumListAsyncVal = ref.watch(orderNumListProvider);

    return orderNumListAsyncVal.when( //注文番号を監視
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text(error.toString()),
        data: (event) {
          //注文番号リスト
          final orderNumListSnap = event.snapshot.children.toList()
              ..sort((orderNumSnap1, orderNumSnap2) { //timestamp昇順でソート
                final int timestamp1 = (orderNumSnap1.value as Map<String, dynamic>)["timestamp"];
                final int timestamp2 = (orderNumSnap2.value as Map<String, dynamic>)["timestamp"];
                return timestamp1 - timestamp2;
              });
          // print(event.snapshot.children[0]);
          //リストが空のとき
          if (orderNumListSnap.isEmpty) {
            return Center(
              child: Text(
                emptyText,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.grey
                ),
              )
            );
          }

          return ListView.separated(
              itemCount: orderNumListSnap.length + 1,
              separatorBuilder: (context, index) => const Divider(height: 0, color: Colors.black),
              itemBuilder: (context, orderNumIndex) {
                //最後の線
                if (orderNumIndex == orderNumListSnap.length) {
                  return Container();
                }
                //1つの注文番号の複数の注文ドキュメント
                final orderNumSnap = orderNumListSnap[orderNumIndex];
                final orderNum = int.parse(orderNumSnap.key ?? "0");
                final mapInOrderNum = orderNumSnap.value as Map<String, dynamic>; //{orderList: [{},{},{}], orderStatus: gave}
                final orderList = mapInOrderNum["orderList"] as List<dynamic>; //[{},{},{}]


                return Row(
                  children: [
                    //注文番号(左)
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          OrderNum(orderNum: orderNum),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: subStateWidgetFunc(orderNum),
                          ),
                        ],
                      ),
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
                              //1つの注文番号の1つの注文ドキュメント
                              final orderMap = orderList[index] as Map<String, dynamic>;
                              final orderParams = OrderParams.getInstance(orderMap);

                              if (stackImage) return StackItemTile(orderParams: orderParams ,displayPrice: displayPrice);
                              return ItemTile(orderParams: orderParams ,displayPrice: displayPrice);
                            },
                          ),
                        )
                    ),
                  ],
                );
              }
          );


          // return ListView.separated(
          //   itemCount: orderNumListSnap.length,
          //   separatorBuilder: (context, index) => const Divider(height: 0, color: Colors.black,),
          //   itemBuilder: (_, index) {
          //     final orderSnap = orderNumListSnap[index];
          //     //各パラメータ取り出し
          //     final orderParams = OrderParams.getInstance(orderSnap); //各種データ
          //     final int orderNum = orderParams.orderNum; //132
          //
          //     return Row(
          //       children: [
          //         //注文番号(左)
          //         Container(
          //           margin: const EdgeInsets.all(20),
          //           child: Column(
          //             children: [
          //               OrderNum(orderNum: orderNum),
          //               Container(
          //                 margin: const EdgeInsets.only(top: 10),
          //                 child: subStateWidgetFunc(orderNum),
          //               ),
          //             ],
          //           ),
          //         ),
          //         //オーダー一覧(右)
          //         Expanded(
          //             child: Container(
          //               decoration: const BoxDecoration(
          //                 border: Border(left: BorderSide(color: Colors.grey)),
          //               ),
          //               child: ListView.separated(
          //                 shrinkWrap: true,
          //                 physics: const NeverScrollableScrollPhysics(),
          //                 itemCount: orderList.length,
          //                 separatorBuilder: (context, index) => const Divider(height: 0),
          //                 itemBuilder: (context, index) {
          //                   //1つの注文番号の注文リスト
          //                   final orderObj = orderList[index];
          //
          //                   return ItemTile(orderObj: orderObj);
          //                 },
          //               ),
          //             )
          //         ),
          //       ],
          //     );
          //     //注文番号リストに更新が入った分だけ新しい項目を作成する
          //     // final orderListAsyncVal = ref.watch(orderListFamily(orderNums[orderNumIndex]));
          //
          //     return orderListAsyncVal.when(
          //         loading: () => const CircularProgressIndicator(),
          //         error: (error, stackTrace) => Text(error.toString()),
          //         data: (event) {
          //           //注文リスト(複数の注文がリストになっている)
          //           final orderListSnap = event.snapshot.children.toList();
          //
          //           //注文番号
          //           final orderNum = orderNums[orderNumIndex];
          //
          //         }
          //     );
          //   },
          // );
        }
    );
  }
}
