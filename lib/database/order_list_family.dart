import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//インスタンス初期化
final db2 = FirebaseDatabase.instance;

final orderListFamily = StreamProvider.family<DatabaseEvent, int>((ref, orderNumId) async* {
  print("DBからorderListを読込");
  final orderListStream = db2.ref("orderNums/$orderNumId/orderList")
      .onValue;

  yield* orderListStream;
});
