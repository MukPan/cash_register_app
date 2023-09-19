import 'package:cash_register_app/component/order_num.dart';
import 'package:cash_register_app/context/order_status_mark.dart';
import 'package:cash_register_app/provider/order_list_family.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../context/item_tile.dart';

///ワンチャンまだ使うかも
// class GaveLogList extends HookConsumerWidget {
//   const GaveLogList({
//     Key? key,
//     required this.gaveNumListProvider,
//     required this.emptyText
//   }) : super(key: key);
//
//   ///表示するdocsプロバイダー
//   final StreamProvider<DatabaseEvent>
//     gaveNumListProvider;
//   ///リストが空のときに表示するテキスト
//   final String emptyText;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //注文番号リスト
//     final gaveNumDocsAsyncVal = ref.watch(gaveNumListProvider);
//     //表示するボタン
//
//     return gaveNumDocsAsyncVal.when(
//       loading: () => const CircularProgressIndicator(),
//       error: (error, stackTrace) => Text(error.toString()),
//       data: (event) {
//         //データベースから注文番号リストの取得
//         final List<int> gaveOrderNums = event.snapshot.children //親：orderNums
//             .map((childSnapshot) => int.parse(childSnapshot.key ?? "0")) //132, 134...
//             .toList();
//
//         //リストが空のとき
//         if (gaveOrderNums.isEmpty) {
//           return Center(
//               child: Text(
//                 emptyText,
//                 style: const TextStyle(
//                     fontSize: 30,
//                     color: Colors.grey
//                 ),
//               )
//           );
//         }
//
//         ListView.separated(
//           itemCount: gaveOrderNums.length,
//           separatorBuilder: (context, index) => const Divider(height: 0, color: Colors.black,),
//           itemBuilder: (parentContext, orderNumIndex) {
//             //注文番号リストに更新が入った分だけ新しい項目を作成する
//             final orderListAsyncVal = ref.watch(orderListFamily(gaveOrderNums[orderNumIndex]));
//
//             return orderListAsyncVal.when(
//                 loading: () => const CircularProgressIndicator(),
//                 error: (error, stackTrace) => Text(error.toString()),
//                 data: (orderList) {
//                   //注文番号
//                   final orderNum = gaveOrderNums[orderNumIndex];
//                   return Row(
//                     children: [
//                       //注文番号(左)
//                       Container(
//                         margin: const EdgeInsets.all(20),
//                         child: Column(
//                           children: [
//                             OrderNum(orderNum: orderNum),
//                             OrderStatusMark(doc: orderNumDocs[orderNumIndex]),
//                           ],
//                         ),
//                       ),
//                       //オーダー一覧(右)
//                       Expanded(
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               border: Border(left: BorderSide(color: Colors.grey)),
//                             ),
//                             child: ListView.separated(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: orderList.length,
//                               separatorBuilder: (context, index) => const Divider(height: 0),
//                               itemBuilder: (context, index) {
//                                 //1つの注文番号の注文リスト
//                                 final orderObj = orderList[index];
//
//                                 return ItemTile(orderObj: orderObj);
//                               },
//                             ),
//                           )
//                       ),
//                     ],
//                   );
//                 }
//             );
//           },
//         );
//       }
//     );
//
//     return orderNumDocsAsyncVal.when( //注文番号を監視
//         loading: () => const CircularProgressIndicator(),
//         error: (error, stackTrace) => Text(error.toString()),
//         data: (orderNumDocs) {
//           //リストが空のとき
//           if (orderNumDocs.isEmpty) {
//             return Center(
//                 child: Text(
//                   emptyText,
//                   style: const TextStyle(
//                       fontSize: 30,
//                       color: Colors.grey
//                   ),
//                 )
//             );
//           }
//           return ListView.separated(
//             itemCount: orderNumDocs.length,
//             separatorBuilder: (context, index) => const Divider(height: 0, color: Colors.black,),
//             itemBuilder: (parentContext, orderNumIndex) {
//               //注文番号リストに更新が入った分だけ新しい項目を作成する
//               final orderListAsyncVal = ref.watch(orderListFamily(int.parse(orderNumDocs[orderNumIndex].id)));
//
//               return orderListAsyncVal.when(
//                   loading: () => const CircularProgressIndicator(),
//                   error: (error, stackTrace) => Text(error.toString()),
//                   data: (orderList) {
//                     //注文番号
//                     final orderNum = int.parse(orderNumDocs[orderNumIndex].id);
//                     return Row(
//                       children: [
//                         //注文番号(左)
//                         Container(
//                           margin: const EdgeInsets.all(20),
//                           child: Column(
//                             children: [
//                               OrderNum(orderNum: orderNum),
//                               OrderStatusMark(doc: orderNumDocs[orderNumIndex])
//                             ],
//                           ),
//                         ),
//                         //オーダー一覧(右)
//                         Expanded(
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                 border: Border(left: BorderSide(color: Colors.grey)),
//                               ),
//                               child: ListView.separated(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: orderList.length,
//                                 separatorBuilder: (context, index) => const Divider(height: 0),
//                                 itemBuilder: (context, index) {
//                                   //1つの注文番号の注文リスト
//                                   final orderObj = orderList[index];
//
//                                   return ItemTile(orderObj: orderObj, displayPrice: true);
//                                 },
//                               ),
//                             )
//                         ),
//                       ],
//                     );
//                   }
//               );
//             },
//           );
//         }
//     );
//   }
// }
