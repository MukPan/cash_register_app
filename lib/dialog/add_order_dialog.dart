import 'package:cash_register_app/context/item_counter.dart';
import 'package:cash_register_app/database/item_infos.dart';
import 'package:cash_register_app/provider/item_count_provider.dart';
import 'package:cash_register_app/provider/opt_is_enabled_family.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../component/item_img.dart';
import '../context/option_tile.dart';
import '../context/order_add_btn.dart';
import '../context/order_update_btn.dart';
import '../context/subtotal_in_editting.dart';
import '../object/order_params.dart';
import '../provider/amount_per_item_provider.dart';

///注文追加(注文詳細)ダイアログ
void showAddOrderDialog(BuildContext context, WidgetRef ref, ItemInfo itemInfo) {
  //画面サイズ取得
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  //各パラメータ取り出し
  final String itemName = itemInfo.itemName; //"唐揚げ"
  final List<OptInfo> optInfoList = itemInfo.optInfoList; //["焼きチーズ", "ケチャップ"]
  final optNameList = optInfoList.map((optInfo) => optInfo.optName).toList();
  final int amountPerItem = itemInfo.itemPrice; //初期の値段(オプションなし)

  for (final optName in optNameList) {
    ref.read(optIsEnabledFamily(optName).notifier).state = false;
  }
  //商品の個数プロバイダーを初期化
  ref.read(itemCountProvider.notifier).state = 1;
  //初期の1個あたりの商品の値段をプロバイダーに登録
  ref.read(amountPerItemProvider.notifier).state = amountPerItem;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(itemName), //商品名
        content: SizedBox(
          width: screenWidth * 0.7, //7割のサイズ
          height: screenHeight * 0.5, //5割のサイズ
          child: Column(
            children: [
              //商品画像とオプション一覧
              Expanded(
                child: Row(
                  children: [
                    //商品画像
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: ItemImg(itemName: itemName, size: screenWidth * 0.2),
                    ),
                    //オプション一覧
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: optInfoList.length,
                            separatorBuilder: (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: OptionTile(optInfo: optInfoList[index]),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //カウンター
              const Divider(),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // これで両端に寄せる
                  children: [
                    //カウンター
                    ItemCounter(amountPerItem: amountPerItem),
                    //小計
                    const SubtotalInEditting()
                  ],
                ),
              )

            ],
          ),
        ),
        actions: [
          // OrderAddBtn 商品を新しく追加する
          OrderAddBtn(
            optInfoList: optInfoList,
            itemName: itemName,
          ),
        ],
      );
    },
  );
}
