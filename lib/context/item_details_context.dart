import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';
import '../provider/total_amount_notifier.dart';
import '../provider/selected_order_num_notifier.dart';
//TODO: 合計金額をStateにして、ここから更新する
//TODO: ロード画面を表示する

class ItemDetailsContext extends HookConsumerWidget {
  const ItemDetailsContext({Key? key}) : super(key: key);


  ///商品詳細リストを取得するメソッド
  ///ドキュメントリファレンスから商品ドキュメントを参照する
  Future<String> getItemDetailsFuture(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
    WidgetRef ref) async {
      //リザルト用のStrバッファ
      StringBuffer resultBuffer = StringBuffer();
      //合計金額
      int totalAmount = 0;

      //docから各パラメータ取得
      final itemDocRef = doc.data()["item"];
      final optionDocRefList = doc.data()["options"];
      final qty = doc.data()["qty"];

      print(itemDocRef);
      print(optionDocRefList);

      //型チェック
      if (itemDocRef is! DocumentReference<Map<String, dynamic>>) return "Incorrect itemDocRef";
      if (optionDocRefList is! List<dynamic>) return "Incorrect optionDocRefList";
      if (optionDocRefList.any((optionDocRef) =>
        optionDocRef is! DocumentReference<Map<String, dynamic>>)) return "Incorrect optionDocRef";
      if (qty is! int) return "Incorrect qty";

      //商品詳細を取得
      await itemDocRef.get().then((DocumentSnapshot doc) {
        final String itemName = doc.id;
        final int itemPrice = (doc.data() as Map<String, dynamic>)["price"];
        //バッファに追記
        resultBuffer.writeln("$itemName: $itemPrice円    ×$qty");
        //合計金額に加算
        totalAmount += itemPrice * qty;
      });

      //商品詳細を取得
      for (final optionDocRef in optionDocRefList) {
        await optionDocRef.get().then((DocumentSnapshot doc) {
          final String optionName = doc.id;
          final int optionPrice = (doc.data() as Map<String, dynamic>)["price"];
          //バッファに追記
          resultBuffer.writeln("    $optionName: $optionPrice円");
          //合計金額に加算
          totalAmount += optionPrice * qty;
        });
      }
      //合計金額をプロバイダーに登録
      ref.read(totalAmountProvider.notifier).changeState(totalAmount);
      return resultBuffer.toString();
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //注文番号
    final orderNum = ref.read(selectedOrderNumProvider);
    //合計金額
    // final totalAmount = ref.read(totalAmountProvider);
    //注文詳細リスト
    late List<String> itemDetailList;
    //注文内容をまとめたコレクション
    final orderCollection = db
        .collection("orderNumCollection")
        .doc(orderNum.toString())
        .collection("orderCollection");

    //注文番号から注文内容を呼び出す
    final getItemDetailListFuture = orderCollection.get().then((querySnapshot) async {
      //State更新用の注文詳細リストを作成
      final tmpItemDetailList = (await Future.wait(querySnapshot.docs
          .map((doc) => getItemDetailsFuture(doc, ref))))
        .toList();

      return tmpItemDetailList;
      });



    //return Widget//
    return FutureBuilder(
        future: getItemDetailListFuture, //Futureを監視
        builder: (_, snapshot) {
          //未取得の場合空のコンテナを返す
          if (!snapshot.hasData) return Container();

          //then()処理後の返り値を受け取る
          itemDetailList = snapshot.data ?? ["取得に失敗しました。"];

          return Container(
            width: MediaQuery.of(context).size.width/2.0 - 60.0, //TODO: paddingを試す
            color: CupertinoColors.systemGrey3,
            margin: const EdgeInsets.all(30.0), //できれば比率によって余白を変えたい
            child: Scrollbar(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) => Text(itemDetailList[index]),
                  separatorBuilder: (BuildContext context, int index) => Container(),
                  itemCount: itemDetailList.length,
                )
            ),
          );
        }
    );
  }
}

// Future<String> getItemDetailsFuture(docRefList) async {
//
//   String result = "miss1";
//   //型チェック
//   if (docRefList is! List) return "miss2";
//   final itemDocRef = docRefList[0];
//   final optionListDocRef = docRefList[1];
//   print("nu");
//   print(optionListDocRef[1]);
//
//   if (itemDocRef is! DocumentReference<Map<String, dynamic>>) return "miss3";
//   if (optionListDocRef is! DocumentReference<Map<String, dynamic>>) return "miss4";
//   // if (docRefList is! List<DocumentReference<Map<String, dynamic>>>) return "miss3";
//
//   late String itemName;
//   late int itemPrice;
//
//   //商品詳細を取得
//   await itemDocRef.get().then((DocumentSnapshot doc) {
//     itemName = doc.id;
//     itemPrice = (doc.data() as Map<String, dynamic>)["price"];
//     result = "$itemName: $itemPrice円";
//   });
//
//   //オプション詳細を取得
//   await optionListDocRef.get().then((DocumentSnapshot doc) {
//     print(doc);
//     // itemName = doc.id;
//     // itemPrice = int.parse((doc.data() as Map<String, dynamic>)["price"]);
//   });
//
//   return result;
// }