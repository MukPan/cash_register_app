import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'item_counter.dart';
import '../component/item_img.dart';
import '../component/item_name.dart';
import '../component/option_names.dart';
import '../component/subtotal.dart';
import '../dialog/edit_order_dialog.dart';
import '../object/order_params.dart';

class ItemDetailsContext extends HookConsumerWidget {
  const ItemDetailsContext({Key? key, required this.orderListSnap}) : super(key: key);

  ///注文リスト
  final List<DataSnapshot> orderListSnap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: orderListSnap.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (_, index) {
          final orderSnap = orderListSnap[index];
          //各パラメータ取り出し
          final orderParams = OrderParams.getInstanceFromSnap(orderSnap);
          final String itemName = orderParams.itemName; //"唐揚げ"
          final int qty = orderParams.qty; //3(個)
          final List<String> optNameList = orderParams.optNameList; //["焼きチーズ", "ケチャップ"]
          final int subtotal = orderParams.subtotal; //1200(円)

          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // これで両端に寄せる
              children: [
                //左寄り
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr, //L→R 指定しないとツールでエラー
                    children: [
                      //1行目
                      Row(
                        children: [
                          ItemName(itemName: itemName),
                          IconButton( //編集ダイアログを表示
                            onPressed: () { showEditOrderDialog(context, ref, orderParams, index); },
                            icon: const Icon(Icons.edit)
                          ) //編集ボタン
                        ],
                      ),
                      //2行目以降
                      OptionNames(optNameList: optNameList),
                      //カウンタ
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          "個数: $qty",
                          style: const TextStyle(
                              fontSize: 20
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //右寄り
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end, //center
                    textDirection: TextDirection.ltr,
                    children: [
                      ItemImg(itemName: itemName),
                      Subtotal(subtotal: subtotal)
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}
