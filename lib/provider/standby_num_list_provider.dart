import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final standbyNumListProvider = StreamProvider<List<int>>((ref) async* {
  //インスタンスの初期化
  final db = FirebaseFirestore.instance;

  //待機番号リストをStreamで返す
  final Stream<List<int>> standbyNumListStream = db.collection("orderNumCollection")
      .where("isPaid", isEqualTo: true) //支払い完了
      .where("isCompleted", isEqualTo: false) //未完成
      .where("isGave", isEqualTo: false) //お渡し前
      .snapshots()
      .map((querySnapshot) {
        //snapshotをリストに変換
        return querySnapshot.docs
            .map((doc) => int.parse(doc.id))
            .toList(growable: false);
  });

  yield* standbyNumListStream;
});

