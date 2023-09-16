import 'package:cash_register_app/component/order_num.dart';
import 'package:cash_register_app/provider/order_list_family.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../context/item_tile.dart';

class RealtimeOrderList extends HookConsumerWidget {
  const RealtimeOrderList({
    Key? key,
    required this.orderNumListProvider,
    required this.subStateWidgetFunc,
    required this.emptyText
  }) : super(key: key);

  ///表示するリストのプロバイダー
  final AutoDisposeStreamProvider<List<int>> orderNumListProvider;
  ///注文番号に働きかけるボタンsubStateWidgetFunc
  final Widget Function(int orderNum) subStateWidgetFunc;
  ///リストが空のときに表示するテキスト
  final String emptyText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //注文番号リスト
    final orderNumListAsyncVal = ref.watch(orderNumListProvider);
    //表示するボタン

    return orderNumListAsyncVal.when( //注文番号を監視
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text(error.toString()),
        data: (orderNumList) {
          //リストが空のとき
          if (orderNumList.isEmpty) {
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
            itemCount: orderNumList.length,
            separatorBuilder: (context, index) => const Divider(height: 0, color: Colors.black,),
            itemBuilder: (parentContext, orderNumIndex) {
              //注文番号リストに更新が入った分だけ新しい項目を作成する
              final orderListAsyncVal = ref.watch(orderListFamily(orderNumList[orderNumIndex]));

              return orderListAsyncVal.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stackTrace) => Text(error.toString()),
                  data: (orderList) {

                    //注文番号
                    final orderNum = orderNumList[orderNumIndex];
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
                                child: subStateWidgetFunc(orderNumList[orderNumIndex]),
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
