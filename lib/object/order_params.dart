

import 'package:firebase_database/firebase_database.dart';

import '../database/item_infos.dart';
import '../database/opt_infos.dart';

class OrderParams {
  OrderParams({
    required this.itemName,
    required this.qty,
    required this.optNameList,
    required this.subtotal
  });


  ///商品名
  final String itemName;
  ///個数
  final int qty;
  ///オプションリスト
  final List<String> optNameList;
  ///(オプション含めた)小計
  final int subtotal;


  ///DataSnapshotからインスタンス作成
  ///orderSnap.valueが
  ///{item: たこ焼き, options: [ソース, 青のり, 焼きチーズ], qty: 3}の形
  static OrderParams getInstanceFromSnap(DataSnapshot orderSnap) {
    final orderMap = orderSnap.value as Map<String, dynamic>; //Object?型を変換

    return getInstance(orderMap);
  }

  ///Mapからインスタンス作成
  ///{item: たこ焼き, options: [ソース, 青のり, 焼きチーズ], qty: 3}の形
  static OrderParams getInstance(Map<String, dynamic> orderMap) {
    //各パラメータ取り出し
    final String itemName = orderMap["item"]; //"唐揚げ"
    final int qty = orderMap["qty"]; //3(個)
    final List<String> optNameList = ((orderMap["options"] ?? []) as List<dynamic>)
        .map((option) => option.toString()) //dynamic -> String
        .toList(); //["焼きチーズ", "ケチャップ"]
    final int itemPrice = itemInfos.itemPriceMap[itemName] ?? 0;
    final int optsPrice = (optNameList.isNotEmpty)
        ? optNameList
        .map((optName) => optInfos.optPriceMap[optName] ?? 0)
        .reduce((sum, price) => sum + price)
        : 0;
    final int subtotal = qty * (itemPrice + optsPrice);

    return OrderParams(
        itemName: itemName,
        qty: qty,
        optNameList: optNameList,
        subtotal: subtotal
    );
  }
}