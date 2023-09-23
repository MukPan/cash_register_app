import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

///ワンチャンまだ使う
// class OrderStatusMark extends StatelessWidget {
//   const OrderStatusMark({Key? key, required this.doc}) : super(key: key);
//
//   ///注文番号
//   final QueryDocumentSnapshot<Map<String, dynamic>> doc;
//
//
//   ///ステータスを表す文字を取得
//   String _getTextStatus(bool isCompleted, bool isGave) {
//     if(isCompleted == false) return "未調理";
//     if(isGave == false) return "  完成  ";
//     return "受取済";
//   }
//
//   ///ステータスを表す色を取得
//   Color _getColorStatus(bool isCompleted, bool isGave) {
//     if(isCompleted == false) return Colors.red;
//     if(isGave == false) return Colors.orange;
//     return Colors.green;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final bool isPaid = doc.data()["isPaid"];
//     final bool isCompleted = doc.data()["isCompleted"];
//     final bool isGave = doc.data()["isGave"];
//
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       padding: const EdgeInsets.only(left: 5, right: 5),
//       color: _getColorStatus(isCompleted, isGave),
//       child: Center(
//         child: Text(
//           _getTextStatus(isCompleted, isGave),
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 25,
//           ),
//         ),
//       ),
//     );
//   }
// }
