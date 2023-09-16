import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../object/option_object.dart';
import '../object/order_object.dart';

///合計金額
int _totalAmount = 0;

///合計金額算出用の変数を初期化
void initTotalAmount() {
  _totalAmount = 0;
}

int getTotalAmount() => _totalAmount;

///商品詳細リストを取得するメソッド
///与えられたドキュメントを値オブジェクトへ変換する
Future<OrderObject> convertDocToObjFuture(
    QueryDocumentSnapshot<Map<String, dynamic>> doc) async {

  //docから各パラメータ取得
  final itemDocRef = doc.data()["item"];
  final optionDocRefList = doc.data()["options"];
  final qty = doc.data()["qty"];

  //型チェック
  if (itemDocRef is! DocumentReference<Map<String, dynamic>>) return OrderObject();
  if (optionDocRefList is! List<dynamic>) return OrderObject();
  if (optionDocRefList.any((optionDocRef) =>
  optionDocRef is! DocumentReference<Map<String, dynamic>>)) return OrderObject();
  if (qty is! int) return OrderObject();


  //リザルト用パラメータ
  late final String resItemName;
  late final int resItemPrice;
  final int resItemQty = qty;
  final List<OptionObject> resOptionList = [];

  //商品詳細を取得
  await itemDocRef.get().then((DocumentSnapshot doc) {
    final String itemName = doc.id;
    final int itemPrice = (doc.data() as Map<String, dynamic>)["price"];
    //変数に記録
    resItemName = itemName;
    resItemPrice = itemPrice;

    //合計金額に加算
    _totalAmount += itemPrice * qty;
  });

  //オプション詳細を取得
  for (final optionDocRef in optionDocRefList) {
    await optionDocRef.get().then((DocumentSnapshot doc) {
      final String optionName = doc.id;
      final int optionPrice = (doc.data() as Map<String, dynamic>)["price"];
      //オプションをリストに追加
      resOptionList.add(
          OptionObject(
              optionName: optionName,
              optionPrice: optionPrice
          )
      );
      //合計金額に加算
      _totalAmount += optionPrice * qty;
    });
  }

  //値オブジェクトで返却
  return OrderObject(
      itemName: resItemName,
      itemPrice: resItemPrice,
      itemQty: resItemQty,
      optionList: resOptionList
  );
}