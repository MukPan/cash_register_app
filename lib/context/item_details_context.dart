import 'package:cash_register_app/object/option_object.dart';
import 'package:cash_register_app/object/order_object.dart';
import 'package:cash_register_app/provider/item_count_family.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../component/item_counter.dart';
import '../component/item_img.dart';
import '../component/item_name.dart';
import '../component/option_names.dart';
import '../component/subtotal.dart';
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
  ///与えられたドキュメントを値オブジェクトへ変換する
  Future<OrderObject> convertDocToObjFuture(
      QueryDocumentSnapshot<Map<String, dynamic>> doc,
      WidgetRef ref) async {

    //docから各パラメータ取得
    final itemDocRef = doc.data()["item"];
    final optionDocRefList = doc.data()["options"];
    final qty = doc.data()["qty"];

    //型チェック
    if (itemDocRef is! DocumentReference<Map<String, dynamic>>) return OrderObject();
    if (optionDocRefList is! List<dynamic>) return OrderObject();
    if (optionDocRefList.any((optionDocRef) =>
    optionDocRef is! DocumentReference<Map<String, dynamic>>)) return OrderObject();
    if (qty is! int) return OrderObject();

    //リザルト用パラメータ
    late final String resItemName;
    late final int resItemPrice;
    final int resItemQty = qty;
    final List<OptionObject> resOptionList = [];

    //商品詳細を取得
    await itemDocRef.get().then((DocumentSnapshot doc) {
      final String itemName = doc.id;
      final int itemPrice = (doc.data() as Map<String, dynamic>)["price"];
      //変数に記録
      resItemName = itemName;
      resItemPrice = itemPrice;

      //合計金額に加算 //TODO: 消す
      _totalAmount += itemPrice * qty;
      // print("$itemPrice * $qty  : $_totalAmount");
    });

    //オプション詳細を取得
    for (final optionDocRef in optionDocRefList) {
      await optionDocRef.get().then((DocumentSnapshot doc) {
        final String optionName = doc.id;
        final int optionPrice = (doc.data() as Map<String, dynamic>)["price"];
        //オプションをリストに追加
        resOptionList.add(
            OptionObject(
                optionName: optionName,
                optionPrice: optionPrice
            )
        );
        //合計金額に加算 //TODO: 消す
        _totalAmount += optionPrice * qty;
        print("$optionPrice * $qty  : $_totalAmount");
      });
    }

    //値オブジェクトで返却
    return OrderObject(
      itemName: resItemName,
      itemPrice: resItemPrice,
      itemQty: resItemQty,
      optionList: resOptionList
    );
  }


  ///ビルド
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //注文番号
    final orderNum = ref.read(selectedOrderNumProvider);
    //注文詳細リスト
    late List<OrderObject> orderObjList;
    //注文内容をまとめたコレクション
    final orderCollection = db
        .collection("orderNumCollection")
        .doc(orderNum.toString()) //注文番号のドキュメントにアクセス
        .collection("orderCollection");

    //注文番号から注文内容を呼び出す
    //orderCollection(querySnapshot)には複数の商品ドキュメントが格納されている
    final getOrderObjListFuture = orderCollection.get().then((querySnapshot) async {
      //State更新用の注文詳細リストを作成
      final List<OrderObject> tmpOrderObjList = (await Future.wait(querySnapshot
          .docs.map((doc) => convertDocToObjFuture(doc, ref)))) //商品ドキュメントを値オブジェクトに変換
          .toList();
      //合計金額をプロバイダーに登録&初期化
      ref.read(variousAmountsProviderFamily(VariousAmounts.totalAmount).notifier).state = _totalAmount;
      ref.read(variousAmountsProviderFamily(VariousAmounts.depositAmount).notifier).state = 0;
      ref.read(variousAmountsProviderFamily(VariousAmounts.changeAmount).notifier).state = -_totalAmount;
      //貨幣の枚数も初期化
      for (String moneyId in moneyIdList) {
        ref.read(moneyCountProviderFamily(moneyId).notifier).state = 0;
      }
      //各個数をプロバイダーに登録
      tmpOrderObjList.asMap().forEach((index, orderObj) {
        ref.read(itemCountFamily(index).notifier).state = orderObj.itemQty;
      });
      //計算終了後に合計金額変数を初期化
      initTotalAmount();
      //Future処理完了
      return tmpOrderObjList;
    });



    //return Widget//
    return FutureBuilder(
        future: getOrderObjListFuture, //Futureを監視
        builder: (_, snapshot) { //snapshot: then()の戻り値の参照？
          //未取得の場合空のコンテナを返す
          if (!snapshot.hasData) return Container();
          if (!(snapshot.connectionState == ConnectionState.done)) return Container();
          //then()処理後の返り値を受け取る
          orderObjList = snapshot.data ?? [];

          return ListView.separated(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: orderObjList.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            //ループ処理//
            itemBuilder: (BuildContext context, int itemIndex) {
              //処理中の値オブジェクト
              final orderObj = orderObjList[itemIndex];

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
                          ItemName(itemName: orderObj.itemName),
                          //2行目以降
                          OptionNames(optList: orderObj.optionList),
                          //カウンタ
                          ItemCounter(index: itemIndex)
                        ],
                      ),
                    ),
                    //右寄り
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end, //center
                        textDirection: TextDirection.ltr,
                        children: [
                          ItemImg(itemName: orderObj.itemName),
                          Subtotal(orderObj: orderObj)
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          );
        }
    );
  }
}