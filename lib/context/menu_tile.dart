import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../component/item_img.dart';
import '../database/item_infos.dart';
import '../dialog/add_order_dialog.dart';

///メニューのタイル
class MenuTile extends HookConsumerWidget {
  const MenuTile({Key? key, required this.itemInfo}) : super(key: key);

  //商品情報
  final ItemInfo itemInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(10), //これがないとボタン外の影が消えてしまう
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3, //影の大きさ
            foregroundColor: Colors.grey.withAlpha(100), //ボタンを押下時のエフェクト色と文字色(子要素で上書き可能)
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)) //角ばったボタン、数値を上げると丸くなる
            ),
          ),
          onPressed: () {
            //商品詳細ダイアログを表示
            showAddOrderDialog(context, ref, itemInfo);
          }, //押下時ポップアップ
          child: Column(
            children: [
              //商品画像
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: ItemImg(itemName: itemInfo.itemName, size: 80),
              ),
              //商品名
              Text( //buttonの中身、商品名や画像、値段など
                itemInfo.itemName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              //価格
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "${itemInfo.itemPrice}円",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
