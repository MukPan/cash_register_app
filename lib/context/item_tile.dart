import 'package:cash_register_app/object/order_object.dart';
import 'package:flutter/material.dart';

import '../component/item_img.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, required this.orderObj}) : super(key: key);

  final OrderObject orderObj;

  @override
  Widget build(BuildContext context) {
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
                  "${orderObj.itemName}  ×${orderObj.itemQty.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40
                  ),
                ),
                //2行目以降
                ListView.builder(
                  shrinkWrap: true, //TODO: いる？
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderObj.optionList.length,
                  //Widget返却
                  itemBuilder: (BuildContext context, int optIndex) {
                    return Text(
                      "・${orderObj.optionList[optIndex].optionName}",
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
            child: ItemImg(itemName: orderObj.itemName, size: 100),
          )
        ],
      ),
    );
  }
}
