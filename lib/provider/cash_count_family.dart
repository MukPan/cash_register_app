import 'package:cash_register_app/object/denomination_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../object/denominations.dart';
//インスタンス初期化
// final db = FirebaseFirestore.instance;

///お金の枚数の総量
final cashCountFamily = StateProvider.family<int, Denominations>((ref, id) {
  // //doc名を取得
  // final targetAmount = denominationInfoList
  //     .where((info) => info.denominationType == id)
  //     .first
  //     .amount
  //     .toString();
  //
  // final a = await db.collection("moneyCountCollection")
  //   .doc(targetAmount)
  //   .snapshots()
  //   .map((docRef) => docRef.data()?["count"] as int)
  //   .first;

  return 10; //0枚
});


