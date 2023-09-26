import 'package:cash_register_app/context/item_counter.dart';
import 'package:cash_register_app/database/item_infos.dart';
import 'package:cash_register_app/provider/item_count_provider.dart';
import 'package:cash_register_app/provider/opt_is_enabled_family.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../component/item_img.dart';
import '../context/option_tile.dart';
import '../context/order_update_btn.dart';
import '../context/subtotal_in_editting.dart';
import '../object/order_params.dart';
import '../provider/amount_per_item_provider.dart';

///注文編集ダイアログ
void showEditOrderDialog(BuildContext context, WidgetRef ref, OrderParams orderParams, int columnIndex) {
  //画面サイズ取得
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  //各パラメータ取り出し
  final String itemName = orderParams.itemName; //"唐揚げ"
  final int qty = orderParams.qty; //3(個)
  final List<String> optNameList = orderParams.optNameList; //["焼きチーズ", "ケチャップ"]
  final int amountPerItem = orderParams.amountPerItem;

  //参照情報からitemNameを使用して取得
  final ItemInfo targetItemInfo = itemInfos.getList()
    .where((itemInfo) => itemInfo.itemName == itemName)
    .first;
  //オプション候補
  final targetOptInfoList = targetItemInfo.optInfoList;

  //プロバイダーを初期化(全てのオプションを無効"false")
  for (final optName in targetOptInfoList.map((optInfo) => optInfo.optName)) {
    ref.read(optIsEnabledFamily(optName).notifier).state = false;
  }
  //有効なオプションをプロバイダーに登録
  for (final optName in optNameList) {
    ref.read(optIsEnabledFamily(optName).notifier).state = true;
  }
  //商品の個数をプロバイダーに登録
  ref.read(itemCountProvider.notifier).state = qty;
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
                            itemCount: targetOptInfoList.length,
                            separatorBuilder: (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: OptionTile(optInfo: targetOptInfoList[index]),
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
          OrderUpdateBtn(
            columnIndex: columnIndex,
            targetOptInfoList: targetOptInfoList,

          ),
        ],
      );
    },
  );
}
