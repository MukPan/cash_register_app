import 'dart:math' as math;

import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'context/order_list_context.dart';
import 'provider/order_num_list_notifier.dart';

//TODO: GridViewを使って注文番号表示

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

  // debugRepaintRainbowEnabled = true;

  runApp(
      const ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        highlightColor: Colors.white,
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
      //注文番号一覧
      body: const OrderListContext(),

      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          //更新ボタン
          return FloatingActionButton(
              onPressed: () {
                //注文番号コレクションを捜索
                db.collection("orderNumCollection").get().then((querySnapshot) {
                  //データベースから注文番号の取得
                  List<int> currentOrderNumList = querySnapshot.docs
                      .map((doc) => int.parse(doc.id))
                      .toList(growable: false);

                  //stateを更新
                  ref.read(orderNumListProvider.notifier)
                      .changeState([...currentOrderNumList]);
                });
              },
              child: const Icon(Icons.refresh));
        },
      ),
    );
  }
}



//     .map((docSnapshot) => docSnapshot.id)
//     .forEach((orderNum) => print(orderNum));
// });
//
// //注文番号が保持するコレクションに直接アクセス
// db.collection("orderNumCollection").get().then((querySnapshot) {
// querySnapshot.docs
//     .map((docSnapshot) {
// var orderCollection = docSnapshot.data()["orderCollection"];
//
// print(orderCollection.runtimeType);
// // if (orderCollection is Map<String, dynamic>) {
// //
// // }
//
// return docSnapshot.id;
// })
//     .forEach((orderNum) => print(orderNum));
// });
//
// //注文番号から
// db.collection("orderNumCollection/132/orderCollection").get().then((querySnapshot) {
// querySnapshot.docs
//     .map((docSnapshot) => docSnapshot.id)
//     .forEach((id) => print(id));
// que