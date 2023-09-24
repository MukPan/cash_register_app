import 'package:flutter/material.dart';
import '../component/item_img.dart';
import '../context/option_tile.dart';
import '../object/order_params.dart';

///注文編集ダイアログ
void showEditOrderDialog(BuildContext context, OrderParams orderParams) {
  //画面サイズ取得
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  //各パラメータ取り出し
  final String itemName = orderParams.itemName; //"唐揚げ"
  final int qty = orderParams.qty; //3(個)
  final List<String> optNameList = orderParams.optNameList; //["焼きチーズ", "ケチャップ"]
  final int subtotal = orderParams.subtotal; //1200(円)

  int counter = 0;
  List<String> items = [
    'チーズ',
    'ケチャップ',
    'ケチャップ',
    'チーズ',
    'ケチャップ',
    'ケチャップ',
  ];

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
          child: Row(
            children: [
              //商品画像
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: ItemImg(itemName: itemName, size: screenWidth * 0.2),
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: optNameList.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return OptionTile(optName: optNameList[index]);
                    }
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('閉じる'),
          ),
        ],
      );
    },
  );
}
