import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../component/item_counter.dart';
import '../component/item_img.dart';
import '../component/item_name.dart';
import '../component/option_names.dart';
import '../component/subtotal.dart';
import '../object/order_params.dart';

class NewItemDetailsContext extends HookConsumerWidget {
  const NewItemDetailsContext({Key? key, required this.orderListAsyVal}) : super(key: key);

  ///注文リストAsyVal
  final AsyncValue<DatabaseEvent> orderListAsyVal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return orderListAsyVal.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text(error.toString()),
      data: (event) {
        //注文リスト(複数の注文がリストになっている)
        final orderListSnap = event.snapshot.children.toList();

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: orderListSnap.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (_, index) {
            final orderSnap = orderListSnap[index];
            //各パラメータ取り出し
            final orderParams = OrderParams.getInstance(orderSnap);
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
                        ItemName(itemName: itemName),
                        //2行目以降
                        OptionNames(optNameList: optNameList),
                        //カウンタ
                        ItemCounter(qty: qty)
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
            //プロバイダーから商品情報を再取得
            // final itemInfoAsyRef = ref.watch(itemInfoFamily(item));
            // final optInfoAsyRef = ref.watch(optionInfoListProvider);




        }
        );
      }
    );
  }
}
