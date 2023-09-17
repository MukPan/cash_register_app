import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//インスタンスの初期化
final db = FirebaseFirestore.instance;

final allOrderNumDocsProvider = StreamProvider<List<QueryDocumentSnapshot<Map<String, dynamic>>>>((ref) async* {

  //待機番号docをStreamで返す
  final standbyNumListStream = db.collection("orderNumCollection")
      .where("isPaid", isEqualTo: true) //支払い完了(本注文)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs.reversed.take(20).toList()); //20個まで取り出せる

  yield* standbyNumListStream;
});

