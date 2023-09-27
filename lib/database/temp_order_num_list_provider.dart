import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../object/order_status.dart';

//インスタンス初期化
final db2 = FirebaseDatabase.instance;
///仮注文番号リストを取得するStream
final tempOrderNumListProvider = StreamProvider<DatabaseEvent>((ref) async* {
  final tempOrderListStream = db2.ref("orderNums")
      .orderByChild("orderStatus").equalTo(OrderStatus.temp.name)
      .onValue;

  yield* tempOrderListStream;
});
