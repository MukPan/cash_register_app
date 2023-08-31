import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';
//TODO: 合計金額をStateにして、ここから更新する

class ItemsListContext extends HookConsumerWidget {
  const ItemsListContext({Key? key}) : super(key: key);

  ///商品詳細リストを取得するメソッド
  ///ドキュメントリファレンスから商品ドキュメントを参照する
  Future<String> getItemDetailsFuture(docRef) async {
    String result = "miss";
    //型チェック
    if (docRef is! DocumentReference<Map<String, dynamic>>) return "miss";

    await docRef.get().then((DocumentSnapshot doc) {
      //商品詳細を取得
      final name = doc.id;
      final price = (doc.data() as Map<String, dynamic>)["price"];
      result = "$name: $price円";
    });
    return result;
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //注文番号
    final orderNum = ref.read(selectedOrderNumProvider);
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
      return (await Future.wait(querySnapshot.docs
          .map((doc) => doc.data()["item"])
          .map((docRef) => getItemDetailsFuture(docRef))))
          .toList();
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
            width: MediaQuery.of(context).size.width/2.0 - 60.0,
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

