import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//インスタンス初期化
final db2 = FirebaseDatabase.instance;

final tempOrderListProvider = StreamProvider<DatabaseEvent>((ref) async* {
  final tempOrderListStream = db2.ref("orderNums")
      .orderByChild("isPaid").equalTo(false)
      .onValue;

  yield* tempOrderListStream;
});
