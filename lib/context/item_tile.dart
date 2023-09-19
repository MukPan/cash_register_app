import 'package:cash_register_app/database/item_infos.dart';
import 'package:cash_register_app/database/opt_infos.dart';
import 'package:cash_register_app/object/order_object.dart';
import 'package:flutter/material.dart';

import '../component/item_img.dart';
import '../object/order_params.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, required this.orderParams, this.displayPrice = false}) : super(key: key);

  final OrderParams orderParams;

  ///価格を表示するか
  final bool displayPrice;

  @override
  Widget build(BuildContext context) {
    //各パラメータ取り出し
    final String itemName = orderParams.itemName; //"唐揚げ"
    final int qty = orderParams.qty; //3(個)
    final List<String> optNameList = orderParams.optNameList; //["焼きチーズ", "ケチャップ"]
    final int subtotal = orderParams.subtotal; //1200(円)




    return Padding(
      padding: const EdgeInsets.all(15),
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
                Text(
                  "$itemName  ×${qty.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40
                  ),
                ),
                //2行目
                if (displayPrice) Text(
                  "${subtotal.toString()}円",
                  style: const TextStyle(
                    fontSize: 40
                  ),
                ),
                //3行目以降
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: optNameList.length,
                  //Widget返却
                  itemBuilder: (BuildContext context, int optIndex) {
                    return Text(
                      "・${optNameList[optIndex]}",
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          //右寄り
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: ItemImg(itemName: itemName, size: 100),
          )
        ],
      ),
    );
  }
}
