import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemImg extends StatelessWidget {
  const ItemImg({
    Key? key,
    required this.itemName,
    this.size = 80,
    this.alpha = 255,
  }) : super(key: key);

  ///商品名
  final String itemName;
  ///画像サイズ
  final double size;
  ///透過
  final int alpha;

  //TODO: 商品画像もfiresotreに置く
  static const _itemImgPathMap = {
    "唐揚げ" : "images/food/karaage.png",
    "たこ焼き" : "images/food/takoyaki.png",
    "ポテト" : "images/food/potato.png",
    "コーラ" : "images/drink/cola.png",
    "ファンタオレンジ" : "images/drink/fanta_orange.png",
    "ファンタグレープ" : "images/drink/fanta_grape.png",
    "レモンライムソーダ" : "images/drink/lemon_lime_soda.png",
    "緑茶" : "images/drink/green_tea.png",
    "麦茶" : "images/drink/barley_tea.png",
    "水" : "images/drink/water.png",
  };

  @override
  Widget build(BuildContext context) {
    return Image.asset(
        _itemImgPathMap[itemName]!,
        height: size,
        width: size,
        colorBlendMode: BlendMode.modulate,
        color: Colors.white.withAlpha(alpha),
    );
  }
}
