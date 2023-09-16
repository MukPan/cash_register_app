

import 'package:cash_register_app/func/convert_doc_to_obj_future.dart';
import 'package:cash_register_app/object/order_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final db = FirebaseFirestore.instance;

final orderListFamily = FutureProvider.family<List<OrderObject>, int>((ref, orderNumId) async {

  final orderNumQuerySnapshot = await db.collection("orderNumCollection")
      .doc(orderNumId.toString())
      .collection("orderCollection")
      .get();

  //一つの注文番号のオーダーリスト(複数の商品ドキュメント)
  final orderList = (await Future.wait(orderNumQuerySnapshot.docs
      .map((doc) => convertDocToObjFuture(doc))));

  return orderList;
});
