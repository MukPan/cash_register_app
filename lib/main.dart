import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'context/order_list_context.dart';
import 'provider/order_num_list_notifier.dart';
import 'provider/selected_order_num_notifier.dart';

/* プロバイダー */

///注文番号リスト
final orderNumListProvider
  = StateNotifierProvider<OrderNumListNotifier, List<int>>((ref) => OrderNumListNotifier());

final selectedOrderNumProvider
  = StateNotifierProvider<SelectedOrderNumNotifier, int>((ref) => SelectedOrderNumNotifier());

//TODO: 選択した注文番号のプロバイダーを作る

///main関数
void main() {
  runApp(
      const ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

///ホーム
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


///ホームの状態
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注文番号の選択'),
      ),
      //注文番号一覧
      body: const OrderListContext(),

      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return FloatingActionButton(
              onPressed: () => {
                ref.read(orderNumListProvider.notifier)
                    .changeState([...ref.watch(orderNumListProvider), math.Random().nextInt(1000)])
              },
              child: const Icon(Icons.add)
          );
        },
      ),
    );
  }
}