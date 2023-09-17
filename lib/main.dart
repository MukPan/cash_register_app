import 'dart:math' as math;

import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:cash_register_app/context/order_num_list.dart';
import 'package:cash_register_app/object/denominations.dart';
import 'package:cash_register_app/page/cash_count_manager_page.dart';
import 'package:cash_register_app/provider/cash_count_family.dart';
import 'package:cash_register_app/provider/sales_count_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'context/menu_drawer.dart';
import 'firebase_options.dart';

///Firestoreインスタンス
final db = FirebaseFirestore.instance;

//TODO: 選択した注文番号のプロバイダーを作る

///main関数
void main() async {
  //firebase用の初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //デバッグ用
  // debugRepaintRainbowEnabled = true;

  runApp(
      const ProviderScope(child: MyApp())
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //キャッシュカウント初期化
    db.collection("moneyCountCollection")
      .doc("moneyCountDoc")
      .get()
      .then((docRef) {
        final totalCountMap = docRef.data()?["totalCountMap"] as Map<String, dynamic>;
        final tmpTotalCountMap = docRef.data()?["tmpTotalCountMap"] as Map<String, dynamic>;

        //プロバイダー初期化
        for (final info in denominationInfoList) {
          ref.read(cashCountFamily(info.denominationType).notifier)
              .state = totalCountMap[info.name]!;
          ref.read(salesCountFamily(info.denominationType).notifier)
              .state = tmpTotalCountMap[info.name]!;
        }
      });



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        highlightColor: Colors.white,
        indicatorColor: Colors.white,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

///ホーム
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "注文番号の選択"),
      drawer: const MenuDrawer(),
      body: const OrderNumList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          db.collection("orderNumCollection").get().then((querySnapshot) {
            querySnapshot.docs
                .map((doc) => doc.reference)
                .forEach((docRef) {
                  docRef.update({
                    "isPaid": false,
                    "isCompleted": false,
                    "isGave": false,
                  });
            });
          });

        },
        child: const Icon(Icons.cached, color: Colors.white),
      ),
    );
  }
}



// floatingActionButton: Consumer(
// builder: (context, ref, child) {
// //更新ボタン
// return FloatingActionButton(
// onPressed: () {
// //注文番号コレクションを捜索
// db.collection("orderNumCollection").get().then((querySnapshot) {
// //データベースから注文番号の取得
// List<int> currentOrderNumList = querySnapshot.docs
//     .map((doc) => int.parse(doc.id))
//     .toList(growable: false);
//
// //stateを更新
// ref.read(orderNumListProvider.notifier)
//     .changeState([...currentOrderNumList]);
// });
// },
// child: const Icon(Icons.refresh));
// },
// ),