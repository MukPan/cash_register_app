import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final completedNumListProvider = StreamProvider.autoDispose<List<int>>((ref) async* {
  //インスタンスの初期化
  final db = FirebaseFirestore.instance;

  //呼出番号リストをStreamで返す
  final Stream<List<int>> completedNumListStream = db.collection("orderNumCollection")
      .where("isCompleted", isEqualTo: true)
      .snapshots()
      .map((querySnapshot) {
    //snapshotをリストに変換
    return querySnapshot.docs
        .map((doc) => int.parse(doc.id))
        .toList(growable: false);
  });

  yield* completedNumListStream;
});

