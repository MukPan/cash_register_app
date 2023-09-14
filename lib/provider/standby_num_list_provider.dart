import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final standbyNumListProvider = StreamProvider.autoDispose<List<int>>((ref) async* {
  //インスタンスの初期化
  final db = FirebaseFirestore.instance;

  //待機番号リストをStreamで返す
  final Stream<List<int>> standbyNumListStream = db.collection("orderNumCollection")
      .where("isCompleted", isEqualTo: false)
      .snapshots()
      .map((querySnapshot) {
        //snapshotをリストに変換
        return querySnapshot.docs
            .map((doc) => int.parse(doc.id))
            .toList(growable: false);
  });

  yield* standbyNumListStream;
});

