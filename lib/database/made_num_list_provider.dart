import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'order_status.dart';

//インスタンスの初期化
final db2 = FirebaseDatabase.instance;
// final db = FirebaseFirestore.instance;


///受取番号リストStream
final madeNumListProvider = StreamProvider<DatabaseEvent>((ref) async* {
  final standbyNumListStream = db2.ref("orderNums")
      .orderByChild("orderStatus").equalTo(OrderStatus.made.name)
      .onValue;

  yield* standbyNumListStream;
});



// final completedNumListProvider = StreamProvider<List<int>>((ref) async* {
//   //呼出番号リストをStreamで返す
//   final Stream<List<int>> completedNumListStream = db.collection("orderNumCollection")
//       .where("isPaid", isEqualTo: true)
//       .where("isCompleted", isEqualTo: true)
//       .where("isGave", isEqualTo: false) //お渡し前
//       .snapshots()
//       .map((querySnapshot) {
//     //snapshotをリストに変換
//     return querySnapshot.docs
//         .map((doc) => int.parse(doc.id))
//         .toList(growable: false);
//   });
//
//   yield* completedNumListStream;
// });

