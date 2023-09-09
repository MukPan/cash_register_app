import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';
import '../provider/money_count_provider_family.dart';
import '../provider/selected_order_num_notifier.dart';
import '../provider/various_amounts_provider_family.dart';
//TODO: 合計金額をStateにして、ここから更新する
//TODO: ロード画面を表示する

class ItemDetailsContext extends HookConsumerWidget {
  const ItemDetailsContext({Key? key}) : super(key: key);

  ///合計金額
  static int _totalAmount = 0;

  ///合計金額算出用の変数を初期化
  void initTotalAmount() {
    _totalAmount = 0;
  }

  ///商品詳細リストを取得するメソッド
  ///ドキュメントリファレンスから商品ドキュメントを参照する
  Future<String> getItemDetailsFuture(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
    WidgetRef ref) async {
      //リザルト用のStrバッファ
      StringBuffer resultBuffer = StringBuffer();

      //docから各パラメータ取得
      final itemDocRef = doc.data()["item"];
      final optionDocRefList = doc.data()["options"];
      final qty = doc.data()["qty"];


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
        _totalAmount += itemPrice * qty;
        print("$itemPrice * $qty  : $_totalAmount");
      });

      //商品詳細を取得
      for (final optionDocRef in optionDocRefList) {
        await optionDocRef.get().then((DocumentSnapshot doc) {
          final String optionName = doc.id;
          final int optionPrice = (doc.data() as Map<String, dynamic>)["price"];
          //バッファに追記
          resultBuffer.writeln("    $optionName: $optionPrice円");
          //合計金額に加算
          _totalAmount += optionPrice * qty;
          print("$optionPrice * $qty  : $_totalAmount");
        });
      }
      //合計金額をプロバイダーに登録&初期化
      ref.read(variousAmountsProviderFamily(VariousAmounts.totalAmount).notifier).state = _totalAmount;
      ref.read(variousAmountsProviderFamily(VariousAmounts.depositAmount).notifier).state = 0;
      ref.read(variousAmountsProviderFamily(VariousAmounts.changeAmount).notifier).state = -_totalAmount;
      //貨幣の枚数も初期化
      for (String moneyId in moneyIdList) {
        ref.read(moneyCountProviderFamily(moneyId).notifier).state = 0;
      }

      return resultBuffer.toString();
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //注文番号
    final orderNum = ref.read(selectedOrderNumProvider);
    //注文詳細リスト
    late List<String> itemDetailList;
    //注文内容をまとめたコレクションリファレンス
    final orderCollectionRef = db
        .collection("orderNumCollection")
        .doc(orderNum.toString())
        .collection("orderCollection");

    //注文番号から注文内容を呼び出す
    final getItemDetailListFuture = orderCollectionRef.get().then((querySnapshot) async {
      //State更新用の注文詳細リストを作成
      final tmpItemDetailList = (await Future.wait(querySnapshot.docs
          .map((doc) => getItemDetailsFuture(doc, ref))))
        .toList();

      //計算終了後に合計金額変数を初期化
      initTotalAmount();

      return tmpItemDetailList;
      });



    //return Widget//
    return StreamBuilder(
        stream: orderCollectionRef.snapshots(),
        builder: (context, snapshot) {
          //未取得の場合空のコンテナを返す
          if (!snapshot.hasData) return Container();
          if (!(snapshot.connectionState == ConnectionState.active)) return Container();

          print("nuuununun");
          final customOrderDocList = snapshot.data?.docs ?? [];

          DocumentReference a;

          //docから各パラメータ取得
          // final itemDocRef = doc.data()["item"];
          // final optionDocRefList = doc.data()["options"];
          // final qty = doc.data()["qty"];

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: customOrderDocList.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemBuilder: (BuildContext context, int itemIndex) {
              //docから各リファレンス取得
              final itemDocRef
                = customOrderDocList[itemIndex].data()["item"];
              final optionDocRefs
                = customOrderDocList[itemIndex].data()["options"];

              print("optionDocRefs");
              print(optionDocRefs);
              print("itemDocRef");
              print(itemDocRef);

              //型チェック
              if (itemDocRef is! DocumentReference<Map<String, dynamic>>) return Container();
              if (optionDocRefs is! List<dynamic>) return Container();
              if (optionDocRefs.any((optionDocRef) =>
                optionDocRef is! DocumentReference<Map<String, dynamic>>)) return Container();
              // if (qty is! int) return Container();



              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // これで両端に寄せる
                  children: [
                    //左寄り
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr, //L→R 指定しないとツールでエラー
                        children: [
                          //1行目
                          StreamBuilder(
                              stream: itemDocRef.snapshots(),
                              builder: (context, snapshot) {
                                //データ取得チェック
                                if (!snapshot.hasData) return Container();
                                if (!(snapshot.connectionState == ConnectionState.active)) return Container();

                                final itemDoc = snapshot.data;
                                final String? itemName = itemDoc?.id;
                                final int itemPrice = (itemDoc?.data() as Map<String, dynamic>)["price"];
                                return Text(
                                  "$itemName, ${itemPrice.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0
                                  ),
                                );
                              }
                          ),
                          //2行目以降
                          SizedBox(
                            child: ListView.builder(
                              shrinkWrap: true, //TODO: バグり散らかしてる
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: optionDocRefs.length,
                              itemBuilder: (BuildContext context, int optIndex) {
                                return StreamBuilder(
                                  stream: (optionDocRefs[optIndex] as DocumentReference<Map<String, dynamic>>).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!(snapshot.connectionState == ConnectionState.done ||
                                        snapshot.connectionState == ConnectionState.active)) return Container();

                                    final optDoc = snapshot.data;
                                    print(optDoc);
                                    final String? optName = optDoc?.id;
                                    final int optPrice = (optDoc?.data() as Map<String, dynamic>)["price"];
                                    return Text(
                                      "$optName(${optPrice.toString()})",
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          color: CupertinoColors.systemGrey
                                      ),
                                    );

                                  },

                                );
                              },
                            ),
                          )
                          // if (index % 3 != 0) OptionName(index: index),
                          // if (index % 2 != 0) OptionName(index: index+1),
                          // if (index % 5 != 0) OptionName(index: index+2),
                          // OptionName(index: index+3),
                          // //カウンタ
                          // ItemCounter(index: index)
                        ],
                      ),
                    ),
                    //右寄り
                    Expanded(
                      child: Container(),
                    )
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   crossAxisAlignment: CrossAxisAlignment.end, //center
                    //   textDirection: TextDirection.ltr,
                    //   children: [
                    //     Image.asset(_foodImgPathList[index%3], height: 80, width: 80, ),
                    //     Subtotal(index: index)
                    //   ],
                    // )
                  ],
                ),
              );
            },
          );
        }
    );
  }
}

// return FutureBuilder(
// future: getItemDetailListFuture, //Futureを監視
// builder: (_, snapshot) {
// //未取得の場合空のコンテナを返す
// if (!snapshot.hasData) return Container();
// if (!(snapshot.connectionState == ConnectionState.done)) return Container();
//
// //then()処理後の返り値を受け取る
// itemDetailList = snapshot.data ?? ["取得に失敗しました。"];
//
// return Container(
// width: MediaQuery.of(context).size.width/2.0 - 60.0, //TODO: paddingを試す
// color: CupertinoColors.systemGrey3,
// margin: const EdgeInsets.all(30.0), //できれば比率によって余白を変えたい
// child: Scrollbar(
// child: ListView.separated(
// itemBuilder: (BuildContext context, int index) => Text(itemDetailList[index]),
// separatorBuilder: (BuildContext context, int index) => Container(),
// itemCount: itemDetailList.length,
// )
// ),
// );
// }
// );