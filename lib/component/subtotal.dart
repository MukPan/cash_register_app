import 'dart:math' as math;

import 'package:cash_register_app/object/order_object.dart';
import 'package:cash_register_app/provider/one_subtotal_family.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/item_count_family.dart';

class Subtotal extends HookConsumerWidget {
  const Subtotal({Key? key, required this.orderObj}) : super(key: key);

  ///商品値オブジェクト
  final OrderObject orderObj;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //オブジェクトからパラメータを取り出す
    final int qty = orderObj.itemQty;
    final int itemPrice = orderObj.itemPrice;
    final int optionsPrice = orderObj
        .optionList
        .map((optObj) => optObj.optionPrice)
        .reduce((sum, price) => sum + price);
    //小計 = 個数 * (商品価格 + オプション価格)
    final int subtotal = qty * (itemPrice + optionsPrice);

    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10),
      child: Text(
        "$subtotal円",
        style: const TextStyle(
          fontSize: 15.0,
        ),
      ),
    );



  }
}
