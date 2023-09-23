import 'package:cash_register_app/func/convert_doc_to_obj_future.dart';
import 'package:cash_register_app/object/order_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'order_status.dart';

//インスタンス初期化
final db2 = FirebaseDatabase.instance;

//TODO: .familyにしてユーザが表示個数を変えられるようにする
///受取番号リストStream
final gaveNumListProvider = StreamProvider<DatabaseEvent>((ref) async* {
  final gaveNumListStream = db2.ref("orderNums")
      .orderByChild("orderStatus").equalTo(OrderStatus.gave.name)
      .limitToLast(30) //表示個数
      .onValue;

  yield* gaveNumListStream;
});
