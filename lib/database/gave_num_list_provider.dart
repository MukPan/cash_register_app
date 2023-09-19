import 'package:cash_register_app/func/convert_doc_to_obj_future.dart';
import 'package:cash_register_app/object/order_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'order_status.dart';

//インスタンス初期化
final db2 = FirebaseDatabase.instance;
final db = FirebaseFirestore.instance;

///受取番号リストStream
final gaveNumListProvider = StreamProvider<DatabaseEvent>((ref) async* {
  final gaveNumListStream = db2.ref("orderNums")
      .orderByChild("orderStatus").equalTo(OrderStatus.gave.name)
      .onValue;

  yield* gaveNumListStream;
});

//TODO: 消す
// final allOrderListProvider = StreamProvider<List<List<OrderObject>>>((ref) async* {
//   final orderNumSnapshot = await db.collection("orderNumCollection")
//       .where("isPaid", isEqualTo: false)
//       .get();
//
//
//   //支払い済みの注文番号リストを取得
//   final List<String> paidOrderNumList = orderNumSnapshot.docs
//       .map((doc) => doc.id)
//       .toList();
//
//   //全ての注文番号のオーダー(商品ドキュメント)をまとめたリスト
//   List<List<OrderObject>> allOrderList = [];
//
//   //全ての文番号をループで回す
//   for (String orderNum in paidOrderNumList) {
//
//     final orderNumQuerySnapshot = await db.collection("orderNumCollection")
//       .doc(orderNum)
//       .collection("orderCollection")
//       .get();
//
//     //一つの注文番号のオーダーリスト(複数の商品ドキュメント)
//     final orderList = (await Future.wait(orderNumQuerySnapshot.docs
//         .map((doc) => convertDocToObjFuture(doc))));
//
//     allOrderList.add(orderList);
//   }
//
//   yield allOrderList;
// });

// 132
//   [jweoif,hwueifhuiwe,hjwih],
// 133
//   [hrwfoijr,wur3efioh,ohg8r3],
// 134
//   [ohfu,fohu8]



// db.collection("orderNumCollection")
//   .where("isPaid", isEqualTo: true)
//   .snapshots()
//   .forEach((orderNumQuerySnapshot) {
//     final a = orderNumQuerySnapshot.docs
//       .map((orderNumDoc) => orderNumDoc.id)
//       .map((orderNum) {
//         return db.collection("orderNumCollection")
//           .doc(orderNum)
//           .collection("orderCollection")
//           .snapshots()
//           .asyncMap((orderQuerySnapshot) async { //注文ドキュメント群リスト
//             final orderObjectList = await Future.wait(orderQuerySnapshot.docs
//                 .map((orderDoc) => convertDocToObjFuture(orderDoc)));
//             return orderObjectList;
//           }).toList();
//       });
//     });