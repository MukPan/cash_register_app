import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../component/order_num.dart';
import '../main.dart';
import '../page/confirm_order_page.dart';
import '../provider/selected_order_num_notifier.dart';
import '../provider/temp_order_list_provider.dart';

final db2 = FirebaseDatabase.instance;

class OrderNumList extends HookConsumerWidget {
  const OrderNumList({Key? key}) : super(key: key);

  ///注文内容確認画面への遷移メソッド
  void moveConfirmOrderPage(BuildContext context, WidgetRef ref, int orderNum) {
    //状態の更新(選択中の注文番号)
    ref.read(selectedOrderNumProvider.notifier)
        .changeState(orderNum);

    //次ページの移動
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const ConfirmOrderPage();
        }
    ));
  }

  //onValue
  @override
  Widget build(BuildContext context, WidgetRef ref) {

  final tempOrderListAsyncVal = ref.watch(tempOrderListProvider);


  return tempOrderListAsyncVal.when(
    loading: () => const CircularProgressIndicator(),
    error: (error, stackTrace) => Text(error.toString()),
    data: (event) {
      //データベースから注文番号リストの取得
      final List<int> orderNums = event.snapshot.children //親：orderNums
          .map((childSnapshot) => int.parse(childSnapshot.key ?? "0")) //132, 134...
          .toList();

      //リストが空のとき
      if (orderNums.isEmpty) {
        return const Center(
            child: Text(
              "新しい注文はありません。",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey
              ),
            )
        );
      }

      //注文番号リスト
      return Container(
        margin: const EdgeInsets.all(10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,     //ボックス左右間のスペース
              mainAxisSpacing: 10,      //ボックス上下間のスペース
              crossAxisCount: 4,        //ボックスを横に並べる数
            ),
            itemCount: orderNums.length,
            //指定した要素の数分を生成
            itemBuilder: (context, index) {
              return TextButton(
                  onPressed: () { moveConfirmOrderPage(context, ref, orderNums[index]); },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0x10000000)),
                  ),
                  child: OrderNum(orderNum: orderNums[index])
              );
            }
        ),
      );
    }
  );

    return StreamBuilder(
      stream: db.collection("orderNumCollection")
        .where("isPaid", isEqualTo: false) //会計未完了
        .where("isCompleted", isEqualTo: false) //お渡し前
        .where("isGave", isEqualTo: false) //お渡し前
        .snapshots(), //snapshotのstream
      builder: (context, snapshot) {
        //データベースから注文番号リストの取得
        final List<int> currentOrderNumList = snapshot.data?.docs
            .map((doc) => int.parse(doc.id))
            .toList(growable: false)
            ?? <int>[];


        //リストが空のとき
        if (currentOrderNumList.isEmpty) {
          return const Center(
              child: Text(
                "新しい注文はありません。",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey
                ),
              )
          );
        }

        //Widget返却
        return Container(
          margin: const EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,     //ボックス左右間のスペース
              mainAxisSpacing: 10,      //ボックス上下間のスペース
              crossAxisCount: 4,        //ボックスを横に並べる数
            ),
            itemCount: currentOrderNumList.length,
            //指定した要素の数分を生成
            itemBuilder: (context, index) {
              return TextButton(
                  onPressed: () { moveConfirmOrderPage(context, ref, currentOrderNumList[index]); },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0x10000000)),
                  ),
                  child: OrderNum(orderNum: currentOrderNumList[index])
              );
            }

          ),
        );
      }, //snapshotのstream
    );
  }
}
