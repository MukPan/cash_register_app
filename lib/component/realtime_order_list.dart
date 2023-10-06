import 'package:cash_register_app/component/order_num.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../context/item_tile.dart';
import '../database/order_list_family.dart';
import '../object/order_status.dart';
import '../object/order_params.dart';
import 'default_circular_progress_indicator.dart';
import 'stack_item_tile.dart';

class RealtimeOrderList extends HookConsumerWidget {
  const RealtimeOrderList({
    Key? key,
    required this.orderNumListProvider,
    required this.subStateWidgetFunc,
    required this.emptyText,
    this.displayPrice = false,
    this.stackImage = false,
    this.titleWidget,
    this.beforeStatus,
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
  ///タイトルWidget
  final Widget? titleWidget;
  ///取り消した時の注文ステータス
  final OrderStatus? beforeStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //注文番号リスト
    final orderNumListAsyncVal = ref.watch(orderNumListProvider);

    return orderNumListAsyncVal.when( //注文番号を監視
        loading: () => const DefaultCircularProgressIndicator(),
        error: (error, stackTrace) => Text(error.toString()),
        data: (event) {
          //注文番号リスト
          final orderNumListSnap = event.snapshot.children.toList()
              ..sort((orderNumSnap1, orderNumSnap2) { //timestamp昇順でソート
                final int timestamp1 = (orderNumSnap1.value as Map<String, dynamic>)["timestamp"];
                final int timestamp2 = (orderNumSnap2.value as Map<String, dynamic>)["timestamp"];
                return timestamp1 - timestamp2;
              });

          return Column(
            children: [
              //見出し
              titleWidget ?? Container(),
              //注文番号一覧
              (orderNumListSnap.isNotEmpty)
                ? Expanded(
                  child: ListView.separated(
                      itemCount: orderNumListSnap.length + 1,
                      separatorBuilder: (context, index) => const Divider(height: 0, color: Colors.black),
                      itemBuilder: (context, orderNumIndex) {
                        print(orderNumIndex);
                        //最後の線
                        if (orderNumIndex == orderNumListSnap.length) {
                          return Container();
                        }

                        //1つの注文番号の複数の注文ドキュメント
                        final orderNumSnap = orderNumListSnap[orderNumIndex];
                        final orderNum = int.parse(orderNumSnap.key ?? "0");
                        final mapInOrderNum = orderNumSnap.value as Map<String, dynamic>; //{orderList: [{},{},{}], orderStatus: gave}
                        final orderList = (mapInOrderNum["orderList"] != null)
                            ? (mapInOrderNum["orderList"] as Map<String, dynamic>) //[{},{},{}]
                              .entries
                              .map((orderMap) => orderMap.value) //uuidであるkeyは捨てる
                              .toList()
                            : [];


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
                                    child: subStateWidgetFunc(orderNum), //nextBtn
                                  ),
                                  if (beforeStatus != null) IconButton(
                                    onPressed: () {
                                      //データベース取り消し
                                      db2.ref("orderNums/$orderNum/")
                                          .update({"orderStatus": beforeStatus?.name});
                                    },
                                    icon: const Icon(CupertinoIcons.backward_fill),

                                  )
                                ],
                              ),
                            ),
                            //オーダー一覧(右)
                            Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey)),
                                  ),
                                  child: (orderList.isNotEmpty)
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: orderList.length,
                                        separatorBuilder: (context, index) => const Divider(height: 0),
                                        itemBuilder: (context, index) {
                                          //1つの注文番号の1つの注文ドキュメント
                                          final orderMap = orderList[index] as Map<String, dynamic>;
                                          final orderParams = OrderParams.getInstance(orderMap);

                                          if (stackImage) return StackItemTile(orderParams: orderParams, displayPrice: displayPrice);
                                          return ItemTile(orderParams: orderParams, displayPrice: displayPrice);
                                        },
                                      )
                                      : Container()
                                )
                            ),
                          ],
                        );
                      }
                  ),
              )
              //注文がないときのメッセージ
              : Expanded(
                child: Center(
                  child: Text(
                    emptyText,
                    style: const TextStyle(color: Colors.grey, fontSize: 20),
                  )
                ),
              )
            ],
          );
        }
    );
  }
}
