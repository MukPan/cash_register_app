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
import 'database/opt_infos.dart';
import 'object/order_status.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

import 'database/item_infos.dart';

///Firestoreインスタンス
// final db = FirebaseFirestore.instance;
///RealtimeDatabaseインスタンス
FirebaseDatabase db2 = FirebaseDatabase.instance;

//TODO: 選択した注文番号のプロバイダーを作る

///main関数
void main() async {
  //firebase用の初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //参照用データ初期化
  itemInfos.fetchData();
  optInfos.fetchData();

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
    // db2.ref("moneyCount")
    //     .once() //1度だけ(Future)
    //     .then((event) {
    //       final moneyCountMap = event.snapshot.value as Map<String, dynamic>;
    //       final totalCountMap = moneyCountMap["totalCountMap"] as Map<String, dynamic>;
    //       final tmpTotalCountMap = moneyCountMap["tmpTotalCountMap"] as Map<String, dynamic>;
    //       //プロバイダー初期化
    //       for (final info in denominationInfoList) {
    //         ref.read(cashCountFamily(info.denominationType).notifier)
    //             .state = totalCountMap[info.name];
    //         ref.read(salesCountFamily(info.denominationType).notifier)
    //             .state = tmpTotalCountMap[info.name];
    //       }
    //       print("キャッシュカウント用プロバイダ初期化完了");
    //     });
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
class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
    future: initMoneyCountState(ref),
    builder: (context, snapshot) {
      //ロード未完了
      if (snapshot.connectionState != ConnectionState.done) {
        return const CircularProgressIndicator();
      }

      return Scaffold(
        appBar: const DefaultAppBar(title: "注文番号の選択"),
        drawer: const MenuDrawer(),
        body: const OrderNumList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            for (final orderNum in ["132", "134", "621", "622"]) {
              db2.ref("orderNums/$orderNum/")
                  .update({
                "orderStatus": OrderStatus.temp.name
              });
            }
          },
          child: const Icon(Icons.cached, color: Colors.white),
        ),
      );
    }
    );
  }
}



///キャッシュカウントのプロバイダーを初期化する非同期メソッド
Future<void> initMoneyCountState(WidgetRef ref) async {
  //取得まで待機
  final moneyCountEvent = await db2.ref("moneyCount").once();
  //eventを使用
  final moneyCountMap = moneyCountEvent.snapshot.value as Map<String, dynamic>;
  final totalCountMap = moneyCountMap["totalCountMap"] as Map<String, dynamic>;
  final tmpTotalCountMap = moneyCountMap["tmpTotalCountMap"] as Map<String, dynamic>;
  //プロバイダー初期化
  for (final info in denominationInfoList) {
    ref.read(cashCountFamily(info.denominationType).notifier)
        .state = totalCountMap[info.name];
    ref.read(salesCountFamily(info.denominationType).notifier)
        .state = tmpTotalCountMap[info.name];
  }
  print("キャッシュカウント用プロバイダ初期化完了");

  return;
}