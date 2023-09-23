import 'package:cash_register_app/object/denomination_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../object/denominations.dart';

///お金の枚数の総量
final cashCountFamily = StateProvider.family<int, Denominations>((ref, id) {
  return 0;
});


